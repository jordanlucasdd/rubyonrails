class Intranet::Profile

  def initialize
    @client = ClientRest.new(url: APP_CONFIG::INTRANET::URL,id:APP_CONFIG::INTRANET::APP_ID,secret_token:APP_CONFIG::INTRANET::API_TOKEN)
  end

  def get_by_email(email)
    @client.get "profile?email=#{email}", params: nil
  end

  def get(id)
    @client.get "profile?id=#{id}", params: nil
  end

end