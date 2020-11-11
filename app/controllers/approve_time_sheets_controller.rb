class ApproveTimeSheetsController < ApplicationController

  def update
    approve = (params[:approve] == 'ok')
    uc = TimeSheets::UseCases::Approve.new(user_id: @current_user.id, ts_id: params[:id], approve: approve)
    ts = uc.execute
    
    TimeSheets::Services::Notify.new(ts).exec
  end
  
end
