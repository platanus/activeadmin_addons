require 'rails_helper'

describe "Bool column", :type => :feature do
  context "with true paid attribute" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          index do
            bool_column :paid
          end
        end
      end

      Invoice.create(paid: true)
    end

    it "shows 'pagada'" do
      visit admin_invoices_path
      expect(page).to have_content 'pagada'
    end
  end

  context "with false paid attribute" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          index do
            bool_column :paid
          end
        end
      end

      Invoice.create(paid: false)
    end

    it "shows 'no pagada'" do
      visit admin_invoices_path
      expect(page).to have_content 'no pagada'
    end
  end

  context "using a block" do
    before do
      load_resources do
        ActiveAdmin.register(Invoice) do
          index do
            bool_column(:paid) do |invoice|
              !invoice.paid
            end
          end
        end
      end

      Invoice.create(paid: true)
    end

    it "shows 'no pagada'" do
      visit admin_invoices_path
      expect(page).to have_content 'no pagada'
    end
  end
end
