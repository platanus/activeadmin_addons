class AddShippingStatusToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :shipping_status, :string
  end
end
