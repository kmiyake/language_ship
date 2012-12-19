class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale

  def set_locale
    if current_user
      I18n.locale = current_user.native_language.to_sym
    else
      locale = request.preferred_language_from(AVAILABLE_LANGUAGES_CODE)
      I18n.locale = locale || I18n.default_locale
    end
  end

  def login_required
    redirect_to root_url unless current_user
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
