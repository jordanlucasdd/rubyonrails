class HomeController < ApplicationController

  def index
    repository = TimeSheets::Repositories::TimeSheets.new
    
    @approveds = repository.current_time_sheets_approveds_for_user(user_id: @current_user.id).map { |ts| TimeSheetPresenter.new(ts) }
    @total_hours = repository.current_time_sheets_approveds_for_user(user_id: @current_user.id).sum(:percentage)

    @timesheets_to_aprroval = repository.waiting_approval(user_id: @current_user.id).map { |ts| TimeSheetPresenter.new(ts) }
    @approveds_by_me = repository.current_times_sheets_approveds(user_id: @current_user.id)

    @approveds_by_project = map_by_project(@approveds_by_me)
    @approveds_by_person  = map_by_person(@approveds_by_me)

    @timesheets = repository.current_time_sheets_for_user(user_id: @current_user.id)
    
    month = (Date.today - 1.month).month
    @month = I18n.t('date.month_names')[month]
  end

  private
  def map_by_project(timesheets)
    data = []
    ProjectModel.where(id: timesheets.pluck(:project_id).uniq).each do |prj|
        tss = timesheets.select { |t| t.project_id == prj.id }
        data << {project: prj, timesheets: tss }
    end

    data
  end

  def map_by_person(timesheets)
    data = []
    User.where(id: timesheets.pluck(:user_id).uniq).each do |u|
        tss = timesheets.select { |t| t.user_id == u.id }
        data << {user: u, timesheets: tss }
    end

    data
  end
  
end