require "paperclip"
class AddAttachmentToInvoices < ActiveRecord::Migration
  include Paperclip::Schema::Statements

  def change
    add_attachment :invoices, :attachment
    add_attachment :invoices, :photo
  end
end
