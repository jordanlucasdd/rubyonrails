class ProjectTsPresenter

  attr_accessor :project, :time_sheets

  def initialize(data)
    @project = data.project
    @time_sheets = data.times_sheets.map { |ts| TimeSheetPresenter.new(ts) }
  end

end