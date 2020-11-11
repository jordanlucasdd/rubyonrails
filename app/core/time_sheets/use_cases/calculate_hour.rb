module TimeSheets
  class UseCases::CalculateHour

    def initialize(time_sheet:)
      @ts = time_sheet
      @erp = ::ErpApi::Employees.new
    end

    def execute
      total = 0.0
      employees = @erp.get_all_employee_in_date(email: @ts.user.email, year: @ts.year, month: @ts.month)
      employees.each do |employee|
        hire_dates = @erp.employee_hire_dates(employee_id: employee["UKEY"])
        resignation_date = hire_dates["DATA_DESLIGAMENTO"].to_s
        # validate_if_user_is_active(resignation_date,@ts.year,@ts.month)
        if (resignation_date.present?) && (resignation_date.to_date < Date.new(@ts.year, @ts.month, 1))
          total += 0
        else
          maximum_working_hours = @erp.maximum_working_hours(employee_id: employee["UKEY"])
          maximum_working_hours = 160 if maximum_working_hours.nil?
          number_of_hours = hours_performed(@ts.year, @ts.month, hire_dates["DATA_CONTRATACAO"], resignation_date, @ts.percentage, maximum_working_hours) 
          total += number_of_hours.to_f
        end
        
      end

      total.round(2)
    end

    private
    def hours_performed(year, month, hiring_date, resignation_date, percentage_hours, max_allocation_time)


      number_days = Date.new(year, month, 1).end_of_month.day

      if (year.to_i == hiring_date.to_date.year && month.to_i == hiring_date.to_date.month)
        start_date = hiring_date.to_date
        end_date = Date.new(year, month, 1).end_of_month
      elsif (!resignation_date.blank? && year.to_i == resignation_date.to_date.year && month.to_i == resignation_date.to_date.month)
        start_date = Date.new(year, month, 1)
        end_date = resignation_date.to_date
      else
        start_date = Date.new(year, month, 1)
        end_date = start_date.end_of_month
      end
      days_worked = (end_date - start_date).to_i + 1

      ((max_allocation_time.to_f / number_days.to_f) * days_worked) * (percentage_hours.to_f / 100).round(2)
    end

    def validate_if_user_is_active(resignation_date,year,month)
      if (resignation_date.present?) && (resignation_date.to_date < Date.new(year, month, 1))
        raise TimeSheets::Exceptions::Invalid.new "Esse colaborador não pode lançar alocação nesta data, entre em contato com o administrativo"
      end
    end

  end
end