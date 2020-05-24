class CreateInvoicesAndItems < ActiveRecord::Migration[4.2]
  def change
    create_table :invoices_items, id: false do |t|
      t.belongs_to :invoice, index: true
      t.belongs_to :item, index: true
    end
  end
end
