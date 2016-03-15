class AddDragonflyAttachmentToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :dattachment_uid, :string
    add_column :invoices, :dattachment_name, :string
  end
end
