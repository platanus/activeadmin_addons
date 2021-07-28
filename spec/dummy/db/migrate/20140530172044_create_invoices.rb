class CreateInvoices < ActiveRecord::Migration[4.2]
  def change
    create_table :invoices do |t|
      t.date :legal_date
      t.string :number

      t.timestamps
    end
  end
end
