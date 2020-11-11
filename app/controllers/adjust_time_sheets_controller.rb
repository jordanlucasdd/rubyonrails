class AdjustTimeSheetsController < ApplicationController

  def index
    date = Date.today - 1.month
    year = params[:year] || date.year 
    month = params[:month] || date.month
    @current_date = "#{month}/#{year}"
    rep = TimeSheets::Repositories::TimeSheets.new
    @data = rep.times_sheets_aprroveds_by_user_and_date(user_id: @current_user.id, month: month, year: year)
    @dates = rep.time_sheets_dates_aprroveds_by_user(user_id: @current_user.id).map { |dt| "#{dt.month}/#{dt.year}" }
  end

  def new
    @ts = TimeSheets::Repositories::TimeSheets.new.get_or_new(params[:id])
    @projects = Projects::Repositories::Projects.new.by_responsible(@current_user)
    @users = User.order(:name).map { |user| UserPresenter.new(user) }
    @form = FormPresenter.new
  end

  def create
    begin
      date = Date.strptime("1/#{params[:ts][:date]}",'%d/%m/%y')
      year =  date.year
      month = date.month
      id = params[:id] if params[:id] != ""
      uc = TimeSheets::UseCases::Adjust.new(id: id, user_id: params[:ts][:user_id], project_id: params[:ts][:project_id], 
                                          value: params[:ts][:value], month: month, year: year)
      @ts = uc.execute
      
      TimeSheets::Services::Notify.new(@ts).exec

      flash[:notice] = "Adequação de horas realizada"
      redirect_to root_path
    rescue Exception => e
      flash[:notice] = e.message
      redirect_to new_adjust_time_sheet_path({id: params[:id]})
    end
  end
  
end