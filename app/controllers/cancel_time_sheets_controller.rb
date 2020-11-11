class CancelTimeSheetsController < ApplicationController

  def update
    uc = TimeSheets::UseCases::Cancel.new(user_id: @current_user.id, ts_id: params[:id])
    ts = uc.execute
    Users::UseCases::UpdateProjects.new(user_id: @current_user.id, project_id: ts.project.id, action:'remove').execute
    render json: 'ok'
  end

  
end