module TimeSheets
  class Builders::TimeSheet

    def build_from_project(project:, user:, year:, month:)
      model = TimeSheetModel.where(project_id: project.id, user_id: user.id, year: year, month: month).first
      ts = Domain::TimeSheet.new
      ts.project = project
      ts.hours = 0
      ts.percentage = 0
      ts.cost_center = get_cost_center(project.cost_center)
      ts.status = ::STATUS::OPEN
      ts.user = user

      if model 
        ts.hours = model.hours || 0
        ts.percentage = model.percentage || 0
        ts.status = model.status || STATUS::OPEN
        ts.reason_for_disapproval = model.reason_for_disapproval
      end

      ts.year = @year
      ts.month = @month

      ts
    end

    def build(model)
      ts = TimeSheets::Domain::TimeSheet.new
      ts.id = model.id
      ts.project = ::Projects::Builders::Project.new(model.project).build
      ts.hours = model.hours
      ts.percentage = model.percentage
      ts.cost_center = get_cost_center(model.cost_center || ts.project.cost_center)
      ts.status = model.status
      ts.year = model.year
      ts.month = model.month
      ts.reason_for_disapproval = model.reason_for_disapproval
      ts.user = model.user
      
      ts
    end

    private
    def get_cost_center(value)
      # 00.00.00.000.000
      CostCenterFormatter.new.mask(value)
    end

  end
end