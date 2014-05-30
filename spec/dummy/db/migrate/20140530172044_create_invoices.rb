class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.datetime :legal_date
      t.string :number

      t.timestamps
    end
  end
end
