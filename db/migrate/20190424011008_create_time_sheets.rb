class CreateTimeSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :time_sheets do |t|
      t.integer :month
      t.integer :year
      t.integer :project_id
      t.integer :user_id
      t.decimal :hours, precision: 5, scale: 2
      t.integer :percentage
      t.integer :old_ts_id
      t.string  :status
      t.string :reason_for_disapproval
      t.string :cost_center
      t.timestamps
    end
  end
end
