class AddFieldEmployeeContract < ActiveRecord::Migration[5.2]
  def change
    add_column :time_sheets, :employee_contract, :json
  end
end
