class TotalHoursController < ApplicationController

  def index
    rep = TimeSheets::Repositories::TimeSheets.new
    @approveds = rep.current_time_sheets_approveds_for_user(user_id: @current_user.id).map { |ts| TimeSheetPresenter.new(ts) }
    @total_hours = rep.current_time_sheets_approveds_for_user(user_id: @current_user.id).sum(:percentage)
    month = (Date.today - 1.month).month
    @month = I18n.t('date.month_names')[month]
    respond_to do |format|
      format.js {render partial: 'index'}
    end
  end
  
end