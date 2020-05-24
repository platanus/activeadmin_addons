class AddPaidToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :paid, :boolean
  end
end
