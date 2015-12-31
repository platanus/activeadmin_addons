class AddInformationToCities < ActiveRecord::Migration
  def change
    add_column :cities, :information, :text
  end
end
