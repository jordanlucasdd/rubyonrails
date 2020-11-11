module Projects

  class Repositories::Projects

    def recent(user)
      ::ProjectModel.order(:name).where(active_in_gfp: true).where(id: user.recent_projects).map { |prj| Builders::Project.new(prj).build }
    end

    def search(name)
      projects = ::ProjectModel.order(:name).where(active_in_gfp: true).search_by_name("%#{name}")
      projects.map { |prj| Builders::Project.new(prj).build }
    end

    def get(id)
      prj = ::ProjectModel.find_by id: id
      if prj 
        prj = Builders::Project.new(prj).build
      end

      prj
    end

    def by_responsible(user)
      if user.is_admin?
        ::ProjectModel.order(:name).map { |prj| Builders::Project.new(prj).build }
      else
        ::ProjectModel.order(:name).where(responsible_for_approval_id: user.id).map { |prj| Builders::Project.new(prj).build }
      end
    end

  end

end