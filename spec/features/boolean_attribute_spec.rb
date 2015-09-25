require 'rails_helper'

describe "Bool values", :type => :feature do
  context "without block" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          index do
            bool_column :paid
          end
        end
      end
    end

    context "with true paid attribute" do
      before { Invoice.create(paid: true) }

      it "shows 'pagada'" do
        visit admin_invoices_path
        expect(page).to have_content 'pagada'
      end
    end

    context "with false paid attribute" do
      before { Invoice.create(paid: false) }

      it "shows 'no pagada'" do
        visit admin_invoices_path
        expect(page).to have_content 'no pagada'
      end
    end
  end

  context "passing a block" do
    before do
      load_resources do
        ActiveAdmin.register(AdminUser) do
          show do
            attributes_table do
              bool_row(:id) do |admin|
                !admin.id
              end
            end
          end
        end
      end

      @admin = AdminUser.create(email: "admin@platan.us", password: "12345678")
    end

    it "shows 'no pagada'" do
      visit admin_admin_user_path(@admin)
      expect(page).to have_content 'nope'
    end
  end

  context "using default values" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          show do
            attributes_table do
              bool_row(:id) do |invoice|
                !invoice.paid
              end
            end
          end
        end
      end

      @invoice = Invoice.create
    end

    it "shows 'he'" do
      visit admin_invoice_path(@invoice)
      expect(page).to have_content 'he'
    end
  end

  context "using a label" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          show do
            attributes_table do
              bool_row("Already paid", :paid)
            end
          end
        end
      end

      @invoice = Invoice.create
    end

    it "shows custom label" do
      visit admin_invoice_path(@invoice)
      expect(page).to have_content 'Already Paid'
    end
  end
end
