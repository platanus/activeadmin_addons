class AddDragonflyPhotoToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :dphoto_uid, :string
    add_column :invoices, :dphoto_name, :string
  end
end
