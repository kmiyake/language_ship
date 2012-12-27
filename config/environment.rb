# Load the rails application
require File.expand_path('../application', __FILE__)
require Rails.root.join('config', 'load_config')

# Initialize the rails application
LanguageShip::Application.initialize!
