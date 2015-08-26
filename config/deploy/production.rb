set :stage, :production

# dont try and infer something as important as environment from stage name.
set :rails_env, :production

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/damian/ruby/DamianDeGoa'
