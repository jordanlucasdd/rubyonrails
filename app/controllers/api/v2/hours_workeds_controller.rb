class Api::V2::HoursWorkedsController < Api::V2::ApiController

  def index
    rep = TimeSheets::Repositories::TimeSheets.new
    data = rep.time_sheets_aprroveds_by_project(project_id: params[:project_id])    
    render json: {result: data}
  end
  
end