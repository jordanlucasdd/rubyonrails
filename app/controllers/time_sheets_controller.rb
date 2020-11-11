class TimeSheetsController < ApplicationController

  def create
    begin
      uc = TimeSheets::UseCases::SaveCurrent.new(user_id: @current_user.id, 
                                        project_id: params[:ts][:project_id], value: params[:ts][:value])
      @ts = uc.execute

      TimeSheets::Services::Notify.new(@ts).exec

    rescue TimeSheets::Exceptions::Invalid => e
      @validation_message = e.message
    rescue Exception => e
      @validation_message = e.message
    end
    
  end

  def show
    begin
      @ts = TimeSheets::Repositories::TimeSheets.new.current_form_user_by_project(user_id: @current_user.id, 
                                                                                project_id: params[:project_id])
      Users::UseCases::UpdateProjects.new(user_id: @current_user.id, project_id: params[:project_id], action:'add').execute
    rescue UserProjectAlreadyExists => e
      @validation_message = e.message
    end
  end
  
end