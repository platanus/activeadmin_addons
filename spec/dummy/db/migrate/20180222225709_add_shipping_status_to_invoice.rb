class AddShippingStatusToInvoice < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :shipping_status, :string
  end
end
