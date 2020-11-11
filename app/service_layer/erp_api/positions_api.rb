class ErpApi::PositionsApi

  def initialize
    @client = ErpApi::ClientApi.new
  end

  def list
    @client.get 'positions'
  end

  def get(id)
    @client.get "position/#{id}"
  end

end

