class ClientRest

  def initialize(url:,id:,secret_token:)
    @api_url = url
    @app_id = id
    @secret_token = secret_token
  end

  def get(path, params:)
    begin
      url = get_url(path, params)
      response = ::RestClient.get url, headers
      JSON.parse(response)
    rescue RestClient::Exception => e
      handle_error(e)
    end
  end

  def put(path, params:)
    begin
      load_params(params)
      params['_method'] = 'put'
      url = get_url(path)
      request = RestClient.post url, params, headers
      JSON.parse(request)
    rescue RestClient::Exception => e
      handle_error(e)
    end
  end

  def post(path, params:)
    begin
      load_params(params)
      url = get_url(path)
      request = RestClient.post url, params, headers
      JSON.parse(request)
    rescue RestClient::Exception => e
      handle_error(e)
    end
  end

  def delete(path, params:)
    begin
      load_params(params)
      url = get_url(path, params)
      request = RestClient.delete url, params
      JSON.parse(request)
    rescue RestClient::Exception => e
      handle_error(e)
    end
  end

  def get_url(path, params = {})
    url = "#{@api_url}/"
    url << path

    url
  end
  private

  def headers
    { "Authorization" => "Token token=\"#{generate_token}\", app_id=\"#{@app_id}\""}
  end

  def load_params(parameters)
    parameters ||= {}
    parameters[:api_token] = @api_token
    parameters[:device_info] = {plataform:'WEB'}
    parameters[:app] = 'elo-timesheet'
    parameters
  end

  def handle_error(e)
    data = JSON.parse(e.response.body)
    raise ApiError.new code: e.response.code, error: data['msg'], data: data['data']
  end

  def generate_token
    # ApiTokenGenerator.generate @app_id, @secret_token
    @secret_token
  end

end