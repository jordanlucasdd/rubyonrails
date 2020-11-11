mail_conf = YAML.load_file(Rails.root.join("config/app.yml"))[Rails.env]['email']

ActionMailer::Base.smtp_settings = {
  :address => mail_conf['address'],
  :enable_starttls_auto => mail_conf['enable_starttls_auto'],
  :port => mail_conf['port'],
  :authentication => mail_conf['authentication'],
  :user_name => mail_conf['user_name'],
  :password => mail_conf['password'],
  :domain => mail_conf['domain']
}