class AddActiveToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :active, :boolean, default: true
  end
end
