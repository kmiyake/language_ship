class AppointmentsController < ApplicationController
  def new
    @meeting = Meeting.find(params[:meeting_id])
    @appointment = @meeting.appointments.build(
      sender_id: current_user.id,
      recipient_id: @meeting.user_id
    )
  end

  def create
    @meeting = Meeting.find(params[:meeting_id])
    @appointment = @meeting.appointments.build(params[:appointment])

    respond_to do |format|
      if @appointment.save
        UserMailer.apply_email(@meeting, @appointment).deliver
        format.html { redirect_to root_url }
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
        UserMailer.accept_email(@meeting, @appointment).deliver
        @meeting.appointments.where("id != #{@appointment.id}").update_all(reject: true) &&
        @meeting.update_attribute(:success, true)
        format.html { redirect_to root_url }
      end
    end
  end
end
