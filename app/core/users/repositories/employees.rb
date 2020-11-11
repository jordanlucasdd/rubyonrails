module Users
  class Repositories::Employees

    def initialize
      @erp = ::ErpApi::Employees.new
    end

    def get_employee_in_date(user:,month:,year:)

      begin
        data = @erp.get_contract(email: user.email, year: year, month: month)
        office = get_office(employee_id: data['UKEY'], month: month, year: year)
        hire_dates = @erp.employee_hire_dates(employee_id: data['UKEY'])
        data['NOME'] = user.name || user.email
        data['DEPARTMENT_NAME'] = office['DEPARTMENT_NAME']
        data['DATA_CONTRATACAO'] = hire_dates['DATA_CONTRATACAO']
        data['DATA_DESLIGAMENTO'] = hire_dates['DATA_DESLIGAMENTO']
        employee = Users::Builders::Employee.new(data).build
      rescue ApiError => e
        if e.code == 404
          employee = nil
        else
          raise Exception.new e.message
        end
      end
      
      employee
    end

    private
      def get_office(employee_id:,month:,year:)
        begin
          office = @erp.get_department_in_date(employee_id: employee_id, month: month, year: year)
        rescue ApiError => e
          if e.code == 404
            office = '-'
          else 
            raise Exception.new e.message
          end
        end

        office
      end

  end
end

