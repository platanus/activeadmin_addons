class AddAasmStateToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :aasm_state, :string
  end
end
