class AddInformationToRegions < ActiveRecord::Migration[4.2]
  def change
    add_column :regions, :information, :text
  end
end
