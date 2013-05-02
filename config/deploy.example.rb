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

# git
set :scm, 'git'
set :repository,  'git@example.com:notin.git'
set :branch, 'master'

# ssh
set :ssh_options, {:forward_agent => true}

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

namespace :deploy do
  task :restart, :roles => :app do
    sudo 'service thin restart'
  end

  desc 'Symlinks the database.yml'
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:finalize_update', 'deploy:migrate'
after 'deploy:finalize_update', 'deploy:symlink_db'