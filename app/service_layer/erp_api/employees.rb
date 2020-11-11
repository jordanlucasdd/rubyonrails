class ErpApi::Employees

  def initialize
    @client = ErpApi::ClientApi.new
  end

  def list
    @client.get 'employees'
  end

  def get_employee_by_email(email)
    @client.get "employee_by_email/#{email}"
  end

  def get_all_employee_in_date(email:,year:,month:)
    @client.get "get_all_employee_in_date/#{email}/#{year}/#{month}"
  end

  def employee_hire_dates(employee_id:)
    @client.get "employee_hire_dates/#{employee_id}"
  end

  def get_contract(email:,year:,month:)
    @client.get "contract_employee_by_email/#{email}/#{year}/#{month}"
  end

  def get_department_in_date(employee_id:, month:, year:)
    @client.get "department_employee_in_date/#{employee_id}/#{year}/#{month}"
  end

  def maximum_working_hours(employee_id:)

    value = nil
    dtos = @client.get("standard_time_employee/#{employee_id}")
    if dtos 
      dto = dtos.first
      unless dto.blank?
        value = dto["M29_003_N"].to_i
      end
    end
    

    value
  end

end

