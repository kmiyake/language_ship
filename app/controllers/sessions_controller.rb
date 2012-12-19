class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    if user.getting_started
      redirect_to root_url
    else
      # FIXME welcome email design
      # TODO delay job
      #UserMailer.welcome_email(user).deliver
      user.update_attribute(:getting_started, true)
      redirect_to "/#{user.profile_url}/edit"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
