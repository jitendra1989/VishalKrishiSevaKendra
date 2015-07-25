set :stage, :production

# dont try and infer something as important as environment from stage name.
set :rails_env, :production

server '128.199.165.70', user: 'damian', roles: %w{web app db}
