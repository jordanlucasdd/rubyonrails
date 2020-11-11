class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer :gfp_id
      t.integer :old_gfp_id
      t.integer :old_ts_id
      t.string :name
      t.timestamps
    end
  end
end
