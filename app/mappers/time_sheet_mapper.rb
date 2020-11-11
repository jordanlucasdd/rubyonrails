class TimeSheetMapper

  def initialize(model)
    @model = model
  end

  def map
    {
      month_reference: @model.month,
      year_reference: @model.year,
      user_id: @model.user_id,
      project_id: @model.project_id,
      created_at: @model.created_at,
      hours_spent: @model.hours,
      status: @model.status,
      reason_for_disapproval: @model.reason_for_disapproval,
      percentage_hours: @model.percentage,
      user: {id: @model.user.id, name: @model.user.name, email: @model.user.email, erp_id: @model.user.erp_id}
    }
  end

end