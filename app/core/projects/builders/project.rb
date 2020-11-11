module Projects
  class Builders::Project

    def initialize(model)
      @model = model
    end

    def build
      project = Projects::Domain::Project.new
      project.id = @model.id
      project.name = @model.name
      project.gfp_id = @model.old_gfp_id
      project.cost_center = @model.old_cc
      project.responsible_for_approval_id = @model.responsible_for_approval_id
      
      project
    end


  end
end