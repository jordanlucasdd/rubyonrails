module Auth
  module UseCases
    class AuthenticateWithGoogle

      def execute access_token
        user = User.from_omniauth(access_token)

        validate_email(user.email)

        user.google_token = access_token.credentials.token
        refresh_token = access_token.credentials.refresh_token
        user.google_refresh_token = refresh_token if refresh_token.present?
        user.last_login = Time.now.localtime
        user.save

        user
      end

      private
        def validate_email(email)
          domain = email.split('@')[1]
          if domain != 'elogroup.com.br'
            raise AuthenticationFailed.new "#{email} não é um e-mail válido"
          end
        end

    end
  end
end
