class ErpApi::CostCentersApi

  def initialize
    @client = ErpApi::ClientApi.new
  end

  def cc_by_code(code)
    @client.get 'cc/find-by-code', {code: "#{code}"}
  end

end

