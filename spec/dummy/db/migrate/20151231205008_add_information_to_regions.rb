class AddInformationToRegions < ActiveRecord::Migration
  def change
    add_column :regions, :information, :text
  end
end
