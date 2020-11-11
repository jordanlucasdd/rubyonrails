module Api
  class ApiController  < ActionController::Base
    include ActionController::Helpers
    include ActionController::Rendering
    include ActionController::Renderers::All
    include ActionController::HttpAuthentication::Basic::ControllerMethods
    include ActionController::MimeResponds
    include AbstractController::Callbacks
    http_basic_authenticate_with :name => "api", :password => "RTIgxdAEkpHno3OHnWnJbg"
  end
end