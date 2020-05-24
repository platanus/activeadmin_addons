class AddInformationToCities < ActiveRecord::Migration[4.2]
  def change
    add_column :cities, :information, :text
  end
end
