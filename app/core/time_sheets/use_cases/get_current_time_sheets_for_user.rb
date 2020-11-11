module TimeSheets
  class UseCases::GetCurrentTimeSheetsForUser

    def initialize(user_id:)
      @user = User.find user_id
      @date = DateTime.now - 1.month
    end

    def execute
      projects = ::Projects::Repositories::Projects.new.recent(@user)
      projects.map { |prj| TimeSheets::Builders::TimeSheet.new(project: prj, user: @user, year: @date.year, month: @date.month).build }
    end

  end
end