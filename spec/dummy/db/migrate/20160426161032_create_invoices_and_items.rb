class CreateInvoicesAndItems < ActiveRecord::Migration
  def change
    create_table :invoices_items, id: false do |t|
      t.belongs_to :invoice, index: true
      t.belongs_to :item, index: true
    end
  end
end
