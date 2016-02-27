class AddColorAndAmountToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :color, :string
    add_column :invoices, :amount, :float
  end
end
