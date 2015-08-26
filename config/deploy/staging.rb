# Default branch is :master
set :branch, 'development'

set :stage, :staging

# dont try and infer something as important as environment from stage name.
set :rails_env, :staging

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/damian/ruby/stagingDamianDeGoa'
