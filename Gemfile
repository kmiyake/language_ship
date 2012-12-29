source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'http_accept_language'

# database
gem 'mysql2'
gem 'sqlite3'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# web
gem 'jquery-rails'
gem 'twitter-bootstrap-rails', :group => :assets

# authenticate
gem 'omniauth-facebook'

group :development, :test do
  # To use debugger
  gem 'debugger'
  # rspec goodies
  gem 'rspec-rails'
  gem 'capybara'
  gem 'launchy'
  gem 'database_cleaner'
end

group :development do
  # Deploy with Capistrano
  gem 'capistrano'
  gem 'rvm-capistrano'
  gem 'letter_opener'
end

group :test do
  # DRb server for testing frameworks
  gem 'spork'

 # command line tool to easily handle events on file system modifications
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'factory_girl_rails'

  # optionals
  gem 'growl'
  gem 'rb-fsevent', '~> 0.9.1'
end

