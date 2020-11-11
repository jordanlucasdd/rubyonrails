module Users
  class UseCases::GetContract

    def initialize(email:,year:,month:)
      @email = email
      @year  = year
      @month = month
      @erp = ::ErpApi::Employees.new
    end

    def execute
      begin
        @erp.get_contract(email: @email, year: @year, month: @month)
      rescue ApiError => e
        if e.code == 404
          raise Exception.new "Colaborador não encontrado, entre em contato com o administrativo."
        else
          raise Exception.new "Ops.. problemas de conexão com o ERP, por favor, tente mais tarde. #{e.message}"
        end
      end
    end

  end
end