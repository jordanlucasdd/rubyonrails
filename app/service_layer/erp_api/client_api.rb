require 'uri'

class ErpApi::ClientApi

  def initialize
    @username = APP_CONFIG::ERP::USERNAME
    @password = APP_CONFIG::ERP::PASSWORD
    @host = APP_CONFIG::ERP::HOST
  end

  def get(path, params=nil)
    begin
      url = "#{@host}/#{path}"
      unless params.nil?
        query = URI.encode_www_form(params)
        url = "#{url}?#{query}"
      end
      respone = RestClient::Request.execute method: :get, url: url, user: @username, password:@password

      JSON.parse(respone)
    rescue RestClient::Exception => e
      raise ApiError.new code: e.response.code, error: e.response.body, data: nil
    end
  end

end