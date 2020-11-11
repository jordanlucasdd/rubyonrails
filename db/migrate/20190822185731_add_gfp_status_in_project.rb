class AddGfpStatusInProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :active_in_gfp, :boolean
    # execute <<-SQL
    #   CREATE EXTENSION unaccent;
    # SQL
  end
end
