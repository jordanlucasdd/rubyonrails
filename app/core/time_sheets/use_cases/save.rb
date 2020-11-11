module TimeSheets
  class UseCases::Save

    def initialize(id: ,user_id:, project_id:, value:, month:, year:)
      @id       = id
      @user     = User.find user_id
      @project  = Projects::Repositories::Projects.new.get(project_id)
      @value    = value.to_i || 0
      @year     = year
      @month    = month
      @ts_rep   = TimeSheets::Repositories::TimeSheets.new
    end

    def execute

      validate_total_percentage
      contract = get_contract
      if @id.nil?
        ts = TimeSheetModel.where(month: @month, year: @year, 
                                  user_id: @user.id, project_id: @project.id).first_or_initialize
      else
        ts = TimeSheetModel.find @id
        ts.month        = @month
        ts.year         = @year
        ts.user_id      = @user.id
        ts.project_id   = @project.id
      end
      
      ts.cost_center  = @project.cost_center
      ts.percentage = @value
      ts.employee_contract = contract
      ts.hours = TimeSheets::UseCases::CalculateHour.new(time_sheet:ts).execute
      ts.status = STATUS::WAITING_APPROVAL
      ts.save

      ts
      
    end


    private
      def get_contract
        uc = Users::UseCases::GetContract.new(email: @user.email, year: @year, month: @month)
        uc.execute
      end

      def validate_total_percentage
        # SOMAR % de HORAS dos TS no mes e ano e user_id 
        # Se for maior q 100 gerar exceção
        total = @ts_rep.sum_allocation(month: @month, year: @year, user_id: @user.id)
        if (total + @value) > 100
          raise Exceptions::Invalid.new "O percentual de horas não pode ultrapassar 100%. O total atual é #{total.to_i}%" 
        end
      end

  end
end

