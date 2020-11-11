module TimeSheets
  class Repositories::TimeSheets

    def initialize
      date = DateTime.now - 1.month
      @year = date.year
      @month = date.month
    end


    def sum_allocation(month:, year:, user_id:)
      TimeSheetModel.where(month: month, year: year, user_id: user_id)
                    .where("status = '#{STATUS::APPROVED}' or status = '#{STATUS::WAITING_APPROVAL}'").sum(:percentage)
    end

    def time_sheets_aprroveds_by_project(project_id:)
      data = []
      project = ProjectModel.find_by gfp_id: project_id
      users = User.where(id: TimeSheetModel.where(status: STATUS::APPROVED, project_id: project.id).pluck(:user_id).uniq)
      users.each do |user|        
        dto = {user_erp_id: user.erp_id, user_ts_id: user.id, project_id: project.id, allocations: [], total: 0}
        ids = TimeSheetModel.where(status: STATUS::APPROVED).joins(:project).where('projects.gfp_id = ?', project_id).where(user_id: user.id).pluck(:id)
        TimeSheetModel.select('month, year, sum(hours) as hours').where(id: ids).group(:month, :year).each do |alloc|
          dto[:total] += alloc.hours
          dto[:allocations] << {hours: alloc.hours, month: alloc.month, year: alloc.year, project_id: project.id}
        end

        data << dto
      end

      data
      
      
    end

    def current_time_sheets_for_user(user_id:)
      user = User.find user_id
      projects_has_ts = TimeSheetModel.where(user_id: user_id, year: @year, month: @month).pluck(:project_id)
      timesheets_model = TimeSheetModel.where(user_id: user_id, year: @year, month: @month, status: [STATUS::OPEN, STATUS::WAITING_APPROVAL, STATUS::DISAPPROVED])

      projects = []
      ::Projects::Repositories::Projects.new.recent(user).each do |prj|
        projects << prj unless projects_has_ts.include? prj.id
      end

      builder = TimeSheets::Builders::TimeSheet.new
      timesheets = timesheets_model.map { |ts| builder.build(ts) }
      
      projects = projects.map { |prj| builder.build_from_project(project: prj, user: user, year: @year, month: @month)}

      timesheets + projects
    end

    def current_time_sheets_approveds_for_user(user_id:)
      timesheets_model = TimeSheetModel.where(user_id: user_id, year: @year, month: @month, status: [STATUS::APPROVED])
    end

    def current_form_user_by_project(user_id:, project_id:)
      project = ::Projects::Repositories::Projects.new.get(project_id)
      user = User.find user_id
      Builders::TimeSheet.new.build_from_project(project: project, user: user, year: @year, month: @month)
    end

    def times_sheets_aprroveds_by_date(start_month:, start_year:, end_month:, end_year:)
      models = TimeSheetModel.includes(:project).includes(:user)
                             .where(month: start_month..end_month)
                             .where(year: start_year..end_year)
                             .where(status: [STATUS::APPROVED, STATUS::WAITING_APPROVAL, STATUS::OPEN])
                             .order(:month,:year)

      models.map { |ts| TimeSheets::Builders::TimeSheet.new.build (ts) }
    end


    def times_sheets_aprroveds_by_user_and_date(user_id:, month:, year:)
      data = []
      prjs = ProjectModel.where(responsible_for_approval_id: user_id).joins(:time_sheets)
                         .where("time_sheets.year = ?",year).where("time_sheets.month = ?",month)
                         .where("time_sheets.status = ?",STATUS::APPROVED).distinct
      prjs.each do |prj|
        ts = OpenStruct.new(project: prj, time_sheets: prj.time_sheets.where(year: year, month: month, status: STATUS::APPROVED))
        data << ts
      end

      data
    end

    def time_sheets_dates_aprroveds_by_user(user_id:)
      TimeSheetModel.select(:month,:year).where(status: 'approved').joins(:project)
                                         .where("projects.responsible_for_approval_id = ?",user_id)
                                          .order(:year).order(:month).group(:year).group(:month)
    end

    def waiting_approval(user_id:)
      TimeSheetModel.where(status: STATUS::WAITING_APPROVAL).joins(:project)
                     .where("projects.responsible_for_approval_id = ?",user_id)
    end

    def current_times_sheets_approveds(user_id:)
      TimeSheetModel.where(year: @year, month: @month, status: STATUS::APPROVED).joins(:project)
                     .where("projects.responsible_for_approval_id = ?",user_id)
    end

    def get(id)
      model = TimeSheetModel.find id
      Builders::TimeSheet.new.build(model)
    end

    def get_or_new(id)
      model = TimeSheetModel.find_or_initialize_by(id: id)
    end

    def save(ts)
      model = TimeSheetModel.find ts.id
      model.status = ts.status
      model.hours = ts.hours
      model.percentage = ts.percentage
      model.reason_for_disapproval = ts.reason_for_disapproval
      model.cost_center = ts.cost_center.gsub('.','')
      model.save

      TimeSheets::Builders::TimeSheet.new.build(model)
    end

    def destroy(ts)
      model = TimeSheetModel.find ts.id
      model.destroy
    end

    def update_employee_contract(id:, contract:)
      TimeSheetModel.where(id: id).update_all(employee_contract: contract)
    end

  end
end