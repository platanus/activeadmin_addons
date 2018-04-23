require 'rails_helper'

describe "Toggle Bool Builder", type: :feature do
  context "shows corresponding switch" do
    before do
      register_index(Invoice) do
        toggle_bool_column :active
      end
    end

    context "with true value" do
      before do
        @invoice = create_invoice(active: true)
        visit admin_invoices_path
      end

      it "switch is on" do
        switch = find("#toggle-invoice-#{@invoice.id}-active")
        expect(switch[:class]).to include("on")
      end
    end

    context "with false value" do
      before do
        @invoice = create_invoice(active: false)
        visit admin_invoices_path
      end

      it "switch is off" do
        switch = find("#toggle-invoice-#{@invoice.id}-active")
        expect(switch[:class]).not_to include("on")
      end
    end
  end
end
