module Projects
  class Builders::Collaborator

    def initialize(model)
      @model = model
    end

    def build
      collab = ::Domain::Collaborator.new
      collab.name = @model.user.name
      collab.email = @model.user.email
      collab.permissions = @model.permissions

      collab
    end
  
  end
end