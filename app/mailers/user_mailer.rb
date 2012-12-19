#-*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "miyake.kota@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "localhost"
    mail(to: user.email, subject: "Welcome to My Awsome Site")
  end

  def apply_email(meeting, appointment)
    @owner = appointment.recipient
    @guest = appointment.sender
    @meeting = meeting
    @appointment = appointment
    mail(to: @owner.email, subject: "#{@guest.name}さんから言語交換の申請がありました。")
  end

  def accept_email(meeting, appointment)
    @owner = appointment.recipient
    @guest = appointment.sender
    @meeting = meeting
    @appointment = appointment
    mail(to: @guest.email, subject: "#{@owner.name}さんから言語交換の承認がありました。")
  end
end
