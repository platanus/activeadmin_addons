class AddInformationToCountries < ActiveRecord::Migration
  def change
    add_column :countries, :information, :text
  end
end
