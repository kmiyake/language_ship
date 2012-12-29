OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, AppConfig['facebook']['app_id'], AppConfig['facebook']['secret']
end
