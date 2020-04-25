require "rails_helper"

describe "Select 2", type: :feature do
  it { expect(ActiveadminAddons.default_select).to eq('select2') }

  context "when default config is select 2" do
    before do
      ActiveadminAddons.default_select = 'select2'

      register_form(Invoice) do |f|
        f.input :category
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows select control as select 2", js: true do
      expect_select2_options_count_to_eq(3)
      expect(page).not_to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end
  end

  context "when default config is select 2 and select control has default-select class" do
    before do
      register_form(Invoice) do |f|
        f.input :category, input_html: { class: "default-select" }
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows normal select control", js: true do
      expect_select2_options_count_to_eq(0)
      expect(page).to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end
  end

  context "when default config is Active Admin's default" do
    before do
      ActiveadminAddons.default_select = 'default'

      register_form(Invoice) do |f|
        f.input :category
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows normal select control", js: true do
      expect_select2_options_count_to_eq(0)
      expect(page).not_to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end
  end

  context "when default config is Active Admin's default and select control has select 2 class" do
    before do
      ActiveadminAddons.default_select = 'default'

      register_form(Invoice) do |f|
        f.input :category, input_html: { class: "select2" }
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows select control as select 2", js: true do
      expect_select2_options_count_to_eq(3)
      expect(page).not_to have_selector("select.default-select")
      expect(page).to have_selector("select.select2")
    end
  end

  context "when building ActiveAdmin html" do
    describe "the <body> element" do
      it "is present in the document only once" do
        visit admin_invoices_path

        expect(page.all('body').size).to eq 1
      end

      it "contains the data-default-select attribute" do
        visit admin_invoices_path

        body = find("body")
        expect(body['data-default-select']).to eq ActiveadminAddons.default_select
      end
    end
  end
end
