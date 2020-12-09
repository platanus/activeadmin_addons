require 'rails_helper'

describe "Toggle Bool Builder", type: :feature do
  context "when using inside another resource" do
    before do
      register_page(Invoice) do
        index do
          toggle_bool_column :active
        end
      end

      register_show(Category, false) do
        attributes_table do
          row :id
        end

        table_for resource.invoices do
          toggle_bool_column :active
        end
      end
    end

    it "generates the correct url" do
      @category = Category.create(name: "International")
      @invoice = create_invoice(active: true, category: @category)
      visit admin_category_path(@category)

      switch = find("span.toggle-bool-switch")
      expect(switch["data-url"]).to eq("/admin/invoices/#{@invoice.id}")
    end
  end

  context "shows corresponding switch" do
    before do
      register_page(Invoice) do
        index do
          toggle_bool_column :active
        end
      end
    end

    context "with true value" do
      before do
        @invoice = create_invoice(active: true)
        visit admin_invoices_path
      end

      it "generates the correct resource url" do
        switch = find("#toggle-invoice-#{@invoice.id}-active")
        expect(switch["data-url"]).to eq("/admin/invoices/#{@invoice.id}")
      end

      it "switch is on" do
        switch = find("#toggle-invoice-#{@invoice.id}-active")
        expect(switch[:class]).to include("on")
      end
    end

    context "with false value" do
      before do
        @invoice = create_invoice(active: false)
        visit admin_invoices_path
      end

      it "switch is off" do
        switch = find("#toggle-invoice-#{@invoice.id}-active")
        expect(switch[:class]).not_to include("on")
      end
    end
  end
end
