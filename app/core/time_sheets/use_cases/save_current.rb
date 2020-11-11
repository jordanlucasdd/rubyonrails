module TimeSheets
  class UseCases::SaveCurrent

    def initialize(user_id:, project_id:, value:)
      @user = User.find user_id
      @project_id = project_id
      @value = value.to_i || 0
      @date = DateTime.now - 1.month
    end

    def execute
      uc = ::TimeSheets::UseCases::Save.new(id: nil, user_id: @user.id, project_id: @project_id, 
                                            value: @value, month: @date.month, year: @date.year)
      uc.execute
    end

  end
end

