class TimeSheetPresenter < BasePresenter

  attr_accessor :id, :user, :project, :date, :hours, :percentage

  def initialize(model)
    @model = model
    @id = model.id
    @user = UserPresenter.new(model.user)
    @project = model.project
    @date = "#{I18n.t('date.month_names')[model.month]}/#{model.year}"
    @hours = model.hours.to_i
    @percentage = model.percentage
  end



end