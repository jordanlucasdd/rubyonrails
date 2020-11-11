class SyncProjectsController < ApplicationController

  before_action :check_if_is_admin

  def create
    flash[:notice] = "Sincronizando projetos"
    SyncProjectsJob.perform_later()
    redirect_to sync_projects_path
  end
  
end