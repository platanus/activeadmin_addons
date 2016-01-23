class AddPositionToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :position, :integer
  end
end
