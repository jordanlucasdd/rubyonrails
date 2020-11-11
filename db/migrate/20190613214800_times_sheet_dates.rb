class TimesSheetDates < ActiveRecord::Migration[5.2]
  def change
    add_column :time_sheets, :approved_at, :datetime
    add_column :time_sheets, :reproved_at, :datetime
    add_column :time_sheets, :canceled_at, :datetime
  end
end
