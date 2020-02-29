class AddCategoryIdToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_reference :invoices, :category, index: true
  end
end
