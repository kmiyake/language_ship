class MeetingsController < ApplicationController
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @meetings = Meeting.order("date DESC")

    respond_to do |format|
      format.html
    end
  end

  def created
    @meetings = Meeting.order("created_at DESC")

    respond_to do |format|
      format.html { render action: 'index' }
    end
  end

  def today
    @meetings = Meeting.where(date: Date.today)

    respond_to do |format|
      format.html { render action: 'index' }
    end
  end

  def search
    if params[:name]
      @meetings = Meeting.by_name(params[:name])
    elsif params[:teach_language]
      @meetings = Meeting.where(teach_language: params[:teach_language]).order("date DESC")
    end

    respond_to do |format|
      format.html { render action: 'index' }
    end
  end

  def show
    @meeting = Meeting.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @meeting = current_user.meetings.build

    respond_to do |format|
      format.html
    end
  end

  def edit
    @meeting = current_user.meetings.find(params[:id])
  end

  def create
    @meeting = current_user.meetings.build(params[:meeting])

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: t('.meetings.create.success') }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @meeting = current_user.meetings.find(params[:id])

    respond_to do |format|
      if @meeting.update_attributes(params[:meeting])
        format.html { redirect_to @meeting, notice: t('.meetings.update.success') }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @meeting = current_user.meetings.find(params[:id])
    @meeting.destroy

    respond_to do |format|
      format.html { redirect_to meetings_url }
    end
  end
end
