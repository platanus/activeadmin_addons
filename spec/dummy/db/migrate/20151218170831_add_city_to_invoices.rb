class AddCityToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_reference :invoices, :city, index: true
  end
end
