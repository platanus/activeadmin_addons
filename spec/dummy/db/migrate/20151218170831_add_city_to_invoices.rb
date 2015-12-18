class AddCityToInvoices < ActiveRecord::Migration
  def change
    add_reference :invoices, :city, index: true
  end
end
