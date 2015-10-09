class CreateDetails < ActiveRecord::Migration
  def change
    create_table :details do |t|
      t.string :code
      t.text :description
      t.integer :quantity
      t.decimal :amount
      t.references :invoice, index: true

      t.timestamps
    end
  end
end
