require 'csv'
class AllocationReportGenerator


  def initialize()
    @erp = ::ErpApi::Employees.new
    @ts_rep = TimeSheets::Repositories::TimeSheets.new
    @employee_rep = Users::Repositories::Employees.new
    @cc_formatter = CostCenterFormatter.new
    @gfp = Gfp::ProjectsOldApi.new
    @logger ||= Logger.new("#{Rails.root}/log/allocation_report#{Date.today.to_s}.log")
    @errors = []
  end

  def execute(start_date,end_date)

    @logger.info("Executando #{start_date} a #{end_date} - #{Time.zone.now}")

    start_month = start_date.split('/')[0]
    start_year  = start_date.split('/')[1]

    end_month = end_date.split('/')[0]
    end_year  = end_date.split('/')[1]

    path = "#{Rails.root}/tmp/ts-#{start_month}-#{start_year}-#{end_month}-#{end_year}.csv"
    rows = []
    columns = [:id,:nome,:email,:cargo,:função,:nivel,:status_colaborador,:departamento,:projeto,:centro_custo,:alocacao,
               :horas_executadas,:horas_planejadas,:mes,:ano,:status]

    file = CSV.generate(headers: true) do |csv|
      csv << columns
      @ts_rep.times_sheets_aprroveds_by_date(start_month: start_month, start_year: start_year, end_month: end_month, end_year: end_year).each do |ts|

       begin
         employee = get_employee(ts.user,ts.month,ts.year)
         raise Exception.new "Contrato nao encontrado no ERP #{ts.user.email}" if employee.nil?

         hours_planned = get_planning_hour(employee,ts)
         hours_planned = format_number(hours_planned) if hours_planned
         hours = format_number(ts.hours) if ts.hours
         status = get_status(employee,ts.month, ts.year)
         email = ts.user.email if ts.user
         row = [ts.id,employee.name, email,employee.role, employee.function, employee.level, status, employee.office,ts.project.name, 
                @cc_formatter.mask(ts.cost_center), ts.percentage, hours, hours_planned, ts.month, ts.year,status_description(ts.status)]

         csv << row
       rescue Exception => e
         @logger.error("TS - #{ts.id} - #{e.message}")
         save_error(ts,e)
       end

      end

      (start_month .. end_month).each do |month|
        users_without_allocation(month,start_year).each do |user|
          begin
            employee = get_employee(user,month,start_year)
            if employee
              status = get_status(employee,month, start_year)
              row = [user.id,employee.name, user.email, employee.role, employee.function, employee.level, status, employee.office,
                      '', '', 0, 0, 0, month, start_year,'Não alocado']
              csv << row
            end
          rescue Exception => e
            @logger.error("User - #{user.id} - #{e.message}")
          end
          
        end
      end

    end

    File.write(path,file)

    @logger.info("relatorio gerado - #{path} - #{@errors.count} erros")
 
    {path: path, errors: @errors}

  end

  private

    def users_without_allocation(month,year)
      users_with_allocation = TimeSheetModel.where(month:month,year:year).pluck(:user_id).uniq
      User.where('id not in (?)',users_with_allocation)
    end

    def get_active_employee(user,month,year)
      employee = get_employee(user,month,year)
      return employee if employee.hiring_date.nil?

      hiring_date = employee.hiring_date.beginning_of_month
      return employee if hiring_date >= "01/#{month}/#{year}".to_date

      return nil
    end

    def get_employee(user,month,year)
      employee = @employee_rep.get_employee_in_date(user: user, month: month, year: year)

      employee
    end

    def get_planning_hour(employee,ts)
      
      planning = @gfp.planning_employees_by_project(employee_id: employee.id, month: ts.month, year: ts.year )
      unless planning.empty?
        item = planning.select { |dto| dto['project_id'] == ts.project.gfp_id }.first
        hours = item['hours'] if item
      end

      hours
        
    end

    def format_number(value)
      ActionController::Base.helpers.number_to_human(value, precision: 6, separator: ',')
    end

    def get_status(employee,month,year)

      date = "01/#{month}/#{year}".to_date
      if (employee.is_out?) and (employee.dismissal_date.beginning_of_month <= date)
        date_str = employee.dismissal_date.to_date.strftime("%d/%m/%Y")
        status ="Desligado em #{date_str}"
      else
        status = "Ativo"
      end

      status
    end

    def save_error(ts,e)
      @errors << "ts: #{ts.id} - projeto: #{ts.project.name} - user: #{ts.user.email} - #{e.message}"
    end

    def status_description(status)
      return "Aguardando aprovação" if status == STATUS::WAITING_APPROVAL
      return "Aprovado" if status ==  STATUS::APPROVED
      return "Não enviado" if status ==  STATUS::OPEN
      return ""
    end

end
