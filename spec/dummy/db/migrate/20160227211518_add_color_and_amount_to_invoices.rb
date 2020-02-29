class AddColorAndAmountToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :color, :string
    add_column :invoices, :amount, :float
  end
end
