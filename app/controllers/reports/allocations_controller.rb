class Reports::AllocationsController < ApplicationController

  before_action :check_if_is_admin

  def create
    flash[:notice] = "Processando relatório"
    ReportsJob.perform_later(params[:start_date],params[:end_date])
    redirect_to new_reports_allocation_path
  end
  
end