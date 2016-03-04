require 'rails_helper'

describe "Enum tag", type: :feature do
  context "using Enumerize" do
    context "changing state value" do
      before do
        register_index(Invoice) do
          tag_column :state
        end

        Invoice.create(state: :approved)
        visit admin_invoices_path
      end

      it "shows set label" do
        expect(page).to have_content('Approved')
      end

      it "shows valid css class" do
        expect(page).to have_css('.approved')
      end
    end

    context "passing a block" do
      before do
        register_show(Invoice) do
          tag_row(:state) do
            invoice.state
          end
        end

        visit admin_invoice_path(Invoice.create)
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
          tag_row("custom state", :state)
        end

        visit admin_invoice_path(Invoice.create)
      end

      it "shows custom label" do
        expect(page).to have_content 'Custom State'
      end
    end
  end

  context "using Rails Enum" do
    context "changing state value" do
      before do
        register_index(Invoice) do
          tag_column :status
        end

        Invoice.create(status: :archived)
        visit admin_invoices_path
      end

      it "shows set value" do
        expect(page).to have_css('.archived')
      end
    end
  end
end
