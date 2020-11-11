class ProjectsController < ApplicationController

  def index
    repository = ::Projects::Repositories::Projects.new

    respond_to do |format|

      format.json do |json|
        if params[:search]
          @projects = repository.search(params[:search][:name]).map { |prj| ProjectPresenter.new(prj) }
        end
      end

    end
    
  end

  def show
    @project = ::Projects::Repositories::Projects.new.get(params[:id])
    Users::UseCases::UpdateProjects.new(user_id: @current_user.id, project_id: @project.id).execute
  end
  
end