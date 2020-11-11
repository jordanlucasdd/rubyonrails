# config valid for current version and patch releases of Capistrano
lock "~> 3.10.0"

set :application, 'elo-timesheet'
# set :init_system, :systemd

set :repo_url, 'git@github.com:innvent/elo-timesheet.git'
set :branch, ENV["REVISION"] || ENV["BRANCH_NAME"] || "master"
set :use_sudo, false

# setup rbenv.
set :rbenv_type, :system
set :rbenv_ruby, '2.5.3'
set :rbenv_path, '/home/ubuntu/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails puma pumactl sidekiq sidekiqctl}

set :keep_releases, 3

set :linked_files, %w{config/database.yml config/secrets.yml config/app.yml config/sidekiq.yml bin/rails bin/rake}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system }


set(:config_files, %w(
  nginx.conf
  database.example.yml
))

set(:symlinks, [
  {
    source: "nginx.conf",
    link: "/etc/nginx/sites-enabled/#{fetch(:full_app_name)}"
  }
])

set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :ssh_options, known_hosts: Net::SSH::KnownHosts

desc 'Create secrets'
task :create_secrets do 
  on roles(:app) do    
    execute "touch ~/#{fetch(:application)}/shared/config/secrets.yml"
    execute "echo 'production:' >> ~/#{fetch(:application)}/shared/config/secrets.yml"
    execute "echo '  secret_key_base: #{SecureRandom.hex(64)}' >> ~/#{fetch(:application)}/shared/config/secrets.yml"
  end
end


namespace :deploy do
  after :finishing, 'deploy:cleanup'
end

task :setup do 
  invoke 'create_secrets'
end



