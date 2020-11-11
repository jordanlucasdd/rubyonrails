module Api
  class V2::ApiController  < ActionController::API    
    include ActionController::HttpAuthentication::Token::ControllerMethods

    before_action :authenticate

     protected

      # Authenticate the user with token based authentication
      def authenticate
        authenticate_token || render_unauthorized
      end

      def authenticate_token
        authenticate_with_http_token do |token, options|
          valid_token = Digest::SHA2.hexdigest('kpHno3' + 'RTIgxdAEkpHno3OHnWnJbg')
          login_is_valid = (options[:app_id] == 'kpHno3' && token == valid_token)
          raise  AuthenticationFailed.new "api authentication failed" unless login_is_valid
          true
        end
      end

      def render_unauthorized(realm = "Application")
        self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
        render json: {error: "Invalid app credentials"}, status: :unauthorized
      end

  end
end