require 'rails_helper'

describe "Select 2", type: :feature do
  context "Default" do
    before do
      register_form(Invoice) do |f|
        f.input :state
      end

      visit edit_admin_invoice_path(Invoice.first_or_create!)
    end

    it "shows select control as select 2", js: true do
      expect(page).to have_css("span.select2-chosen", count: 1)
    end
  end
end
