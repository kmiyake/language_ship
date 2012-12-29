class UsersController < ApplicationController
  def show
    @user = User.find_by_profile_url(params[:profile_url])
    @meetings = @user.meetings.order("date DESC")
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        I18n.locale = @user.native_language
        format.html { redirect_to user_profile_path(@user.profile_url), notice: t('users.update.success') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  def meetings
    @user = User.find_by_profile_url(params[:profile_url])
    @meetings = @user.meetings.order("date DESC")

    respond_to do |format|
      format.html { render action: 'show' }
    end
  end

  def successes
    @user = User.find_by_profile_url(params[:profile_url])
    @meetings = @user.meetings.where(success: true).order("date DESC")

    respond_to do |format|
      format.html { render action: 'show' }
    end
  end
end
