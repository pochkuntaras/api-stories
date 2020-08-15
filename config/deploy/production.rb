server 'api-stories.pochkun.net', user: 'deploy', roles: %w[app web db], primary: true

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

role :app, %w[deploy@api-stories.pochkun.net]
role :web, %w[deploy@api-stories.pochkun.net]
role :db,  %w[deploy@api-stories.pochkun.net]

set :rails_env, :production
set :stage, :production
set :ssh_options, keys: %w[~/.ssh/id_rsa], forward_agent: true, auth_methods: %w[publickey password]

set :puma_role, :app
