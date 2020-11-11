set :stage, :production

set :branch, "features/range-date-report"


# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths
set :full_app_name, "#{fetch(:application)}"
set :server_name, "elo-timesheet_production"
set :nginx_server_name, 'timesheet.elogroup.com.br ts-2018.elogroup.com.br ts.elogroup.com.br'
set :deploy_user, 'ubuntu'


server '54.86.61.136', user: 'ubuntu', roles: %w{web app db}, primary: true

set :deploy_to, "/home/#{fetch(:deploy_user)}/#{fetch(:full_app_name)}"

# dont try and infer something as important as environment from
# stage name.
set :rails_env, :production

# whether we're using ssl or not, used for building nginx
# config file
set :enable_ssl, true

set :puma_workers, 3
set :puma_threads, [1, 12]

set :nginx_use_ssl, true
set :nginx_ssl_certificate, "/etc/letsencrypt/live/timesheet.elogroup.com.br-0001/fullchain.pem"
set :nginx_ssl_certificate_key, "/etc/letsencrypt/live/timesheet.elogroup.com.br-0001/privkey.pem"
