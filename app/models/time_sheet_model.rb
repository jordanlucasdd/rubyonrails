class TimeSheetModel < ApplicationRecord

  def self.table_name
    'time_sheets'
  end

  belongs_to :user
  belongs_to :project, :class_name => "ProjectModel", :foreign_key => "project_id"


end
