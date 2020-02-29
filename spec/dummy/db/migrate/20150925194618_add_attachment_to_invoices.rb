require "paperclip"
class AddAttachmentToInvoices < ActiveRecord::Migration[4.2]
  include Paperclip::Schema::Statements

  def change
    add_attachment :invoices, :attachment
    add_attachment :invoices, :photo
  end
end
