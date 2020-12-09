require 'rails_helper'

describe "Bool Builder", type: :feature do
  context "shows boolean fields" do
    before do
      register_index(Invoice) do
        bool_column :paid
      end
    end

    context "with true value" do
      before do
        create_invoice(paid: true)
        visit admin_invoices_path
      end

      it "shows localized attribute true value" do
        expect(page).to have_content 'pagada'
      end

      it "shows valid class" do
        col = find("td[class=\"col col-paid\"]").find("span")
        expect(col[:class]).to eq("bool-value true-value")
      end
    end

    context "with false value" do
      before do
        create_invoice(paid: false)
        visit admin_invoices_path
      end

      it "shows localized attribute true value" do
        expect(page).to have_content 'no pagada'
      end

      it "shows valid class" do
        col = find("td[class=\"col col-paid\"]").find("span")
        expect(col[:class]).to eq("bool-value false-value")
      end
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        bool_row(:paid) do
          false
        end
      end

      visit admin_invoice_path(create_invoice)
    end

    it "localizes the value returned from the block" do
      expect(page).to have_content 'no pagada'
    end
  end

  context "using model localization options" do
    before do
      register_show(Invoice) do
        bool_row(:id)
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows the models default value" do
      expect(page).to have_content 'he'
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        bool_row("Already paid", :paid)
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows custom label" do
      expect(page).to have_content 'Already Paid'
    end
  end
end
