class ErpApi::ExpensesApi

  def initialize
    @client = ErpApi::ClientApi.new
  end

  def list(code)
    @client.get 'expenses', {}
  end

  def find_by_id(id)
    @client.get 'expenses/find-by-id', {id: id}
  end

  def list_by_cost_center(cc_code)
    @client.get 'expenses/by-cost-center', {cc_id: cc_code}
  end

end

