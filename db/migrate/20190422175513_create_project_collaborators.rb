class CreateProjectCollaborators < ActiveRecord::Migration[5.2]
  def change
    create_table :project_collaborators do |t|
      t.integer :project_id, null: false
      t.integer :user_id, null: false
      t.string :permissions, array: true, default: []
      t.timestamps
    end
  end
end
