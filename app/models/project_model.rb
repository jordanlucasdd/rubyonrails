class ProjectModel < ApplicationRecord

  include ::PgSearch::Model

  pg_search_scope :search_by_name, against: :name, ignoring: :accents, using: { tsearch: { prefix: true } }

  has_many :time_sheets, :class_name => "TimeSheetModel", :foreign_key => "project_id"

  belongs_to :manager, :class_name => "User", :foreign_key => "responsible_for_approval_id"

  def self.table_name
    'projects'
  end

end
