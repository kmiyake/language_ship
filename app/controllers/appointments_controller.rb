class AppointmentsController < ApplicationController
  before_filter :login_required
  before_filter :must_guest, :except => :accept

  def new
    @meeting = Meeting.find(params[:meeting_id])
    @owner = @meeting.user
    @appointment = @meeting.appointments.build(
      sender_id: current_user.id,
      recipient_id: @owner.id
    )
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @appointment = @meeting.appointments.build(params[:appointment])

    respond_to do |format|
      if @appointment.save
        UserMailer.apply_email(@meeting, @appointment).deliver
        format.html { redirect_to @meeting }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @meeting = Meeting.find(params[:meeting_id])
    @appointment = @meeting.appointments.find_by_sender_id(current_user.id)
    @appointment.destroy

    # TODO 言語交換をキャンセルした際にはメール連絡
    # TODO notice追加
    redirect_to root_url
  end

  def accept
    @meeting = Meeting.find(params[:meeting_id])
    @appointment = @meeting.appointments.find(params[:id])
    respond_to do |format|
      if @appointment.update_attribute(:accept, true) &&
        @meeting.appointments.where("id != #{@appointment.id}").update_all(reject: true) &&
        @meeting.update_attribute(:success, true)
        UserMailer.accept_email(@meeting, @appointment).deliver
        format.html { redirect_to root_url }
      end
    end
  end

  private

  def must_guest
    @meeting = Meeting.find(params[:meeting_id])
    redirect_to root_url if @meeting.user_id == current_user.id
  end
end
