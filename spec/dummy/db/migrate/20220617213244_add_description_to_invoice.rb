class AddDescriptionToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :description, :text
  end
end
