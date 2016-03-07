require 'rails_helper'

describe "Bool values", type: :feature do
  context "shows boolean fields" do
    before do
      register_index(Invoice) do
        bool_column :paid
      end
    end

    it "shows localized attribute true value" do
      Invoice.create(paid: true)
      visit admin_invoices_path
      expect(page).to have_content 'pagada'
    end

    it "shows localized attribute false value" do
      Invoice.create(paid: false)
      visit admin_invoices_path
      expect(page).to have_content 'no pagada'
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        bool_row(:paid) do
          false
        end
      end
      @invoice = Invoice.create
    end

    it "localizes the value returned from the block" do
      visit admin_invoice_path(@invoice)
      expect(page).to have_content 'no pagada'
    end
  end

  context "passing attributes without localization values" do
    before do
      register_show(AdminUser) do
        bool_row(:id)
      end
      @admin = AdminUser.create!(email: "admin@platan.us", password: "12345678")
    end

    it "shows the default true localized value" do
      visit admin_admin_user_path(@admin)
      expect(page).to have_content 'ok'
    end
  end

  context "using model localization options" do
    before do
      register_show(Invoice) do
        bool_row(:id)
      end
      @invoice = Invoice.create
    end

    it "shows the models default value" do
      visit admin_invoice_path(@invoice)
      expect(page).to have_content 'he'
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        bool_row("Already paid", :paid)
      end
      @invoice = Invoice.create
    end

    it "shows custom label" do
      visit admin_invoice_path(@invoice)
      expect(page).to have_content 'Already Paid'
    end
  end
end
