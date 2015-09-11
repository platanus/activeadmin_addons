require 'rails_helper'

describe "Bool column", :type => :feature do
  context "with a paid boolean to true" do
    it "shows 'pagada'" do
      Invoice.create(paid: true)
      visit admin_invoices_path
      expect(page).to have_content 'pagada'
    end
  end
end
