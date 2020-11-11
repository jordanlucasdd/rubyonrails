class ApplicationMailer < ActionMailer::Base
  
  default from: "timesheet@elogroup.com.br"
  layout 'mailer'

  default_url_options[:host] = case APP_CONFIG::EVIRONMENT
  when 'production'
    "ts.elogroup.com.br"
  when 'staging'
    "ts-staging.elogroup.com.br"
  when 'development'
    "localhost:3000"
  end

  def send_mail(to:, subject:)
    mail(to: get_email(to), subject: subject)
  end

  private
    def get_email(email)

      if APP_CONFIG::EVIRONMENT != 'production'
        email = 'iuri@moobile.com.br'
      end

      email
    end

end
