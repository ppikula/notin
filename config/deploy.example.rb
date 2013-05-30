require 'bundler/capistrano'
require 'rvm/capistrano'

load 'deploy/assets'

default_run_options[:pty] = true

# deploy config
set :user, 'user'
set :domain, 'example.com'
set :application, 'notin'
set :deploy_to, '/path/to/deployment/dir'
set :deploy_via, :remote_cache
set :keep_releases, 5

set :static_configs, %w(database facebook)

# git
set :scm, 'git'
set :repository, 'git@example.com:notin.git'
set :branch, 'master'

# ssh
set :ssh_options, {:forward_agent => true}

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    sudo 'service thin restart notin'
  end

  desc 'Symlink config files'
  task :symlink_configs, :roles => :app do
    static_configs.each do |config_file|
      run "ln -nfs #{deploy_to}/shared/config/#{config_file}.yml #{release_path}/config/#{config_file}.yml"
    end

    run "rm -rf #{release_path}/config/initializers/secret_token.rb"
    run "ln -nfs #{deploy_to}/shared/config/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
end

after 'deploy:finalize_update', 'deploy:symlink_configs'
after 'deploy:finalize_update', 'deploy:migrate'