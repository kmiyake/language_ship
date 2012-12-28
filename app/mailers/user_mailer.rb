#-*- coding: utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "LanguageShip<email@languageship.com>"

  def welcome_email(user)
    @user = user
    @url = "http://languageship.com"
    subject = I18n.t("user_mailer.welcome_email.welcome_message")
    mail(to: user.email, subject: subject) do |format|
      format.html
      format.text
    end
  end

  def apply_email(meeting, appointment)
    @owner = appointment.recipient
    @guest = appointment.sender
    @meeting = meeting
    @appointment = appointment
    @url = "http://languageship.com"
    I18n.locale = @owner.native_language
    subject = I18n.t("user_mailer.apply_email.apply_message_for_text", :guest_name => @guest.name, :meeting_date => @meeting.date)
    mail(to: @owner.email, subject: subject) do |format|
      format.html
      format.text
    end
  end

  def accept_email(meeting, appointment)
    @owner = appointment.recipient
    @guest = appointment.sender
    @meeting = meeting
    @appointment = appointment
    @url = "http://languageship.com"
    I18n.locale = @guest.native_language
    subject = I18n.t("user_mailer.accept_email.accept_message_for_text", :owner_name => @owner.name, :meeting_date => @meeting.date)
    mail(to: @guest.email, subject: subject) do |format|
      format.html
      format.text
    end
  end
end
