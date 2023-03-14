class RemoveAttachmentFromInvoices < ActiveRecord::Migration[6.1]
  def change
    remove_attachment :invoices, :attachment
    remove_attachment :invoices, :photo
  end
end
