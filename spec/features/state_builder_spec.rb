require 'rails_helper'

describe "State Builder", type: :feature do
  context "changing state value" do
    before do
      register_index(Invoice) do
        state_column :aasm_state
      end

      create_invoice
      visit admin_invoices_path
    end

    it "shows set label" do
      expect(page).to have_content('Pending')
    end

    it "shows valid css class" do
      expect(page).to have_css('.pending')
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        state_row(:aasm_state) do
          invoice.state
        end
      end

      visit admin_invoice_path(create_invoice)
    end

    it "localizes the value returned from the block" do
      expect(page).to have_content('Pending')
    end

    it "shows valid css class" do
      expect(page).to have_css('.pending')
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        state_row("custom state", :aasm_state)
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows custom label" do
      expect(page).to have_content 'Custom State'
    end
  end

  context "with a named states machine" do
    before do
      register_show(Invoice) do
        state_row(:shipping_status, machine: :shipping)
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows set label" do
      expect(page).to have_content('Stock')
    end

    it "shows valid css class" do
      expect(page).to have_css('.stock')
    end
  end
end
