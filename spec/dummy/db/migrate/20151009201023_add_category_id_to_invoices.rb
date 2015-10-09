class AddCategoryIdToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :category, index: true
  end
end
