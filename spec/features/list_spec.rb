require 'rails_helper'

describe "List", type: :feature do
  context "wihtout options" do
    before do
      register_index(Invoice) do
        list_column :skills
        list_column :contact
      end

      Invoice.create
      visit admin_invoices_path
    end

    it "shows list from array" do
      expect(page.html).to include(
        "<ul><li>Animation</li><li>Branding</li><li>Creative Director</li></ul>")
    end

    it "shows list from hash" do
      expect(page.html).to include("<ul><li><span>twitter:&nbsp<span><i>goku84</i></span></span>\
</li><li><span>facebook:&nbsp<span><i>kamehouse</i></span></span></li></ul>")
    end
  end

  context "with localize option" do
    before do
      register_index(Invoice) do
        list_column :contact, localize: true
      end

      Invoice.create
      visit admin_invoices_path
    end

    it "shows localized list" do
      expect(page.html).to include("<ul><li><span>TwiTTer:&nbsp<span><i>goku84</i></span></span>\
</li><li><span>Face:&nbsp<span><i>kamehouse</i></span></span></li></ul>")
    end
  end

  context "with list_type option" do
    before do
      register_show(Invoice) do
        list_row :skills, list_type: :ol
        list_row :contact
      end

      visit admin_invoice_path(Invoice.create)
    end

    it "shows ordered list" do
      expect(page.html).to include(
        "<ol><li>Animation</li><li>Branding</li><li>Creative Director</li></ol>")
    end

    it "shows unordred list" do
      expect(page.html).to include("<ul><li><span>twitter:&nbsp<span><i>goku84</i></span></span>\
</li><li><span>facebook:&nbsp<span><i>kamehouse</i></span></span></li></ul>")
    end
  end
end
