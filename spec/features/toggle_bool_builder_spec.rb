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

      it "off switch is hidden" do
        off_switch = find("#toggle-invoice-#{@invoice.id}-active-false")
        expect(off_switch[:class]).to include("hidden-switch")
      end

      it "on switch is visible" do
        on_switch = find("#toggle-invoice-#{@invoice.id}-active-true")
        expect(on_switch[:class]).not_to include("hidden-switch")
      end
    end

    context "with false value" do
      before do
        @invoice = create_invoice(active: false)
        visit admin_invoices_path
      end

      it "off switch is visible" do
        off_switch = find("#toggle-invoice-#{@invoice.id}-active-false")
        expect(off_switch[:class]).not_to include("hidden-switch")
      end

      it "on switch is hidden" do
        on_switch = find("#toggle-invoice-#{@invoice.id}-active-true")
        expect(on_switch[:class]).to include("hidden-switch")
      end
    end
  end
end
