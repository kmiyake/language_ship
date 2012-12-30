class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.getting_started
      # FIXME welcome email design
      # TODO delay job
      locale = request.preferred_language_from(AVAILABLE_LANGUAGES_CODE) || I18n.default_locale
      UserMailer.welcome_email(user).deliver
      user.update_attributes(
        { native_language: locale, getting_started: false },
        without_protection: true
      )
      redirect_to edit_account_url
    else
      redirect_to meetings_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
