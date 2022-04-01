class AddPictureDataToInvoice < ActiveRecord::Migration[5.2]
  def change
    add_column :invoices, :picture_data, :text
  end
end
