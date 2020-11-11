class ErpApi::Clients

  def initialize
    @client = ErpApi::ClientApi.new
  end

  def list
    @client.get 'clients'
  end

  def clients_by_name(name)
    @client.get 'clients', {name: "#{name}"}
  end

  def client_by_cnpj(cnpj)
    @client.get 'client/find-by-cnpj', {cnpj: "#{cnpj}"}
  end

  def client_by_id(id)
    @client.get 'client/find-by-id', {id: "#{id}"}
  end

end

