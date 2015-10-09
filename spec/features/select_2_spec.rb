require 'rails_helper'

describe "Selec 2", type: :feature do
  def create_invoice_with_details
    invoice = Invoice.create!
    invoice.details.create!([{ code: '#1' }, { code: '#2' }])
    invoice
  end

  context "Default" do
    before do
      register_form(Invoice) do |f|
        f.input :details
      end

      visit edit_admin_invoice_path(create_invoice_with_details)
    end

    it "shows select control as select 2", js: true do
      expect(page).to have_css("ul.select2-choices", count: 1)
    end
  end
end
