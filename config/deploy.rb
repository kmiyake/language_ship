default_run_options[:pty] = true

set :application, "language_ship"
set :repository, "git://github.com/kmiyake/language_ship.git"
set :scm, "git"
set :user, ENV["DEPLOY_USER"]
set :use_sudo, false 
ssh_options[:port] = ENV["SSH_PORT"]
ssh_options[:keys] = ENV["SSH_KEY"]

require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/#{application}"

role :app, "languageship.com"
role :web, "languageship.com"
role :db,  "languageship.com", :primary => true

after ("deploy:assets:symlink") do
  run "ln -s /home/#{user}/config/#{application}/config.yml #{release_path}/config/config.yml"
end

after ("deploy:create_symlink") do
  run "ln -s /home/#{user}/config/#{application}/database.yml #{release_path}/config/database.yml"
end 
