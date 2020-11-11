class UserProjectsController < ApplicationController

  def update
    Users::UseCases::UpdateProjects.new(user_id: @current_user.id, project_id: params[:project_id], action:params[:command]).execute
  end

end
