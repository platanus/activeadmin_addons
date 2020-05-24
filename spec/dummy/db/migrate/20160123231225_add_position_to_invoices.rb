class AddPositionToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :position, :integer
  end
end
