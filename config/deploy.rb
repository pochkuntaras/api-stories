lock '~> 3.13.0'

set :rvm_type, :system
set :rvm_ruby_version, 'ruby-2.6.6@api-stories'

set :application, 'api-stories'

set :repo_url, 'git@github.com:pochkuntaras/api-stories.git'

set :log_level, :debug

set :pty, true

set :deploy_to, '/home/deploy/api-stories'
set :deploy_user, 'deploy'

set :linked_files, fetch(:linked_files, []).push('config/master.key')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system', 'public/uploads')

set :keep_releases, 5

set :puma_threads, [4, 16]
set :puma_workers, 0

set :puma_bind, "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{release_path}/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true

set :yarn_target_path, -> { release_path.join('public/system') }
set :yarn_flags, "--#{fetch(:stage)} --silent --no-progress"
set :yarn_roles, :all
set :yarn_env_variables, {}

namespace :puma do
  Rake::Task[:stop].clear_actions
  Rake::Task[:restart].clear_actions

  desc 'puma:stop task'
  task :stop do
    on roles(fetch(:puma_role)) do |_role|
      within release_path do
        with rails_env: fetch(:rails_env) do

          if test "[ -f #{shared_path}/tmp/pids/puma.pid ]"
            if test :kill, "-0 $( cat #{shared_path}/tmp/pids/puma.pid )"
              execute :pumactl, "-S #{shared_path}/tmp/pids/puma.state", 'stop'
            else
              execute :rm, fetch(:puma_pid)
            end
          else
            warn 'Puma is not running.'
          end
        end
      end
    end
  end

  desc 'puma:restart task'
  task :restart do
    invoke 'puma:stop'
    invoke 'puma:start'
  end
end
