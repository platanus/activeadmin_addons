class AddAasmStateToInvoices < ActiveRecord::Migration[4.2]
  def change
    add_column :invoices, :aasm_state, :string
  end
end
