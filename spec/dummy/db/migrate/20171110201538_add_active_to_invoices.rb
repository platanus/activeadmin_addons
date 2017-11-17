class AddActiveToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :active, :boolean, default: true
  end
end
