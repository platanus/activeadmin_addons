require 'rails_helper'

describe "List Builder", type: :feature do
  context "wihtout options" do
    before do
      register_index(Invoice) do
        list_column :skills
        list_column :contact
      end

      create_invoice
      visit admin_invoices_path
    end

    it "shows list from array" do
      expect(page.html).to include(
        "<ul><li>Animation</li><li>Branding</li><li>Creative Director</li></ul>"
      )
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

      create_invoice
      visit admin_invoices_path
    end

    it "shows localized list" do
      expect(page.html).to include("<ul><li><span>TwiTTer:&nbsp<span><i>goku84</i></span></span>\
</li><li><span>Face:&nbsp<span><i>kamehouse</i></span></span></li></ul>")
    end
  end

  context "with nested values" do
    before do
      register_show(Invoice) do
        list_row :details, localize: true
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows nested html lists" do
      expect(page.html).to include("<ul><li><span>Título:&nbsp<span><i>Detalle</i></span></span>\
</li><li><span>Categorías:&nbsp<span><i><ul><li>Hogar</li><li>Inversión</li></ul></i></span>\
</span></li><li><span>Foto:&nbsp<span><i><ul><li><span>Path:&nbsp<span><i>invoice.png</i></span>\
</span></li><li><span>Tamaño:&nbsp<span><i>5MB</i></span></span></li><li><span>Geo:&nbsp<span><i>\
<ul><li><span>Latitud:&nbsp<span><i>12.34343</i></span></span></li><li><span>Longitud:&nbsp<span>\
<i>34.4343</i></span></span></li></ul></i></span></span></li></ul></i></span></span></li></ul>")
    end
  end

  context "with list_type option" do
    before do
      register_show(Invoice) do
        list_row :skills, list_type: :ol
        list_row :contact
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows ordered list" do
      expect(page.html).to include(
        "<ol><li>Animation</li><li>Branding</li><li>Creative Director</li></ol>"
      )
    end

    it "shows unordred list" do
      expect(page.html).to include("<ul><li><span>twitter:&nbsp<span><i>goku84</i></span></span>\
</li><li><span>facebook:&nbsp<span><i>kamehouse</i></span></span></li></ul>")
    end
  end
end
