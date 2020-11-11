class ProjectPresenter < BasePresenter

  attr_accessor :id, :name, :cost_center

  def initialize(project)
    @id = project.id
    @cost_center = CostCenterFormatter.new.mask(project.cost_center)
    @name = project.name
  end

end