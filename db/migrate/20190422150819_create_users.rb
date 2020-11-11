class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :google_token
      t.string :google_refresh_token
      t.text :roles, array: true, default: []
      t.string :erp_id
      t.timestamp :last_login
      t.integer :old_ts_id
      t.timestamps
    end
  end
end
