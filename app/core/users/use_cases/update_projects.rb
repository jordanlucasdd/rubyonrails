module Users
  class UseCases::UpdateProjects

    def initialize(user_id:, project_id:, action:)
      @user_id = user_id
      @project_id = project_id
      @action = action
    end

    def execute
      user = User.find @user_id
      if @action == 'add'
        add(user)
      else
        remove(user)
      end

      user.save

    end

    private
      def add(user)
        if user.recent_projects.include? @project_id.to_s
          raise UserProjectAlreadyExists.new "Projecto já adicionado" 
        end
        user.recent_projects.push(@project_id.to_s)
      end

      def remove(user)
        if user.recent_projects.include? @project_id.to_s
          user.recent_projects.delete(@project_id.to_s)
        end
      end

  end


end