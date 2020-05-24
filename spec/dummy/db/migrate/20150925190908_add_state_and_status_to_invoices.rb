class AddStateAndStatusToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :state, :string
    add_column :invoices, :status, :integer
  end
end
