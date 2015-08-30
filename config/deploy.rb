# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'DamianDeGoa'
set :repo_url, 'git@bitbucket.org:archferns/damiandegoa.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

server '128.199.165.70', user: 'damian', roles: %w{web app db}

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end

namespace :figaro do
  desc 'SCP figaro configuration to the shared folder'
  task :setup do
    on roles(:app) do
      upload! 'config/application.yml', "#{shared_path}/application.yml", via: :scp
    end
  end

  desc 'Symlink application.yml to the release path'
  task :symlink do
    on roles(:app) do
      execute "ln -sf #{shared_path}/application.yml #{release_path}/config/application.yml"
    end
  end
end
after 'deploy:started', 'figaro:setup'
after 'deploy:updating', 'figaro:symlink'


namespace :sidekiq do
  task :quiet do
    on roles(:app) do
      execute :sudo, :systemctl, :stop, "sidekiq-#{fetch(:stage)}.service"
    end
  end
  task :restart do
    on roles(:app) do
      execute :sudo, :systemctl, :start, "sidekiq-#{fetch(:stage)}.service"
    end
  end
end

after 'deploy:starting', 'sidekiq:quiet'
after 'deploy:reverted', 'sidekiq:restart'
after 'deploy:published', 'sidekiq:restart'
