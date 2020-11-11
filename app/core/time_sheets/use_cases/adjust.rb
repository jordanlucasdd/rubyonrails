module TimeSheets
  class UseCases::Adjust

    def initialize(id:,user_id:,project_id:,value:,month:,year:)
      @id = id
      @user_id = user_id
      @project_id = project_id
      @value = value
      @month = month
      @year = year
    end

    def execute
      if @id.nil?
        ts = TimeSheetModel.where(user_id: @user_id, project_id: @project_id, month: @month, year: @year).last
        @id = ts.id if ts
      end

      uc = TimeSheets::UseCases::Save.new(id: @id, user_id: @user_id, project_id: @project_id, 
                                          value: @value, month: @month, year: @year)
      ts = uc.execute

      TimeSheets::UseCases::Approve.new(user_id: @user_id,ts_id: ts.id, approve: true).execute
    end

  end
end

