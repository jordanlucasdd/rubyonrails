class AddRecentProjectsUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :recent_projects, :string, array: true, default: []
    add_column :users, :avatar, :string, limit: 400
    add_column :projects, :old_cc, :string, limit: 255
    add_column :projects, :responsible_for_approval_id, :integer
  end
end
