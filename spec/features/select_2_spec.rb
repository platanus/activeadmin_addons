require 'rails_helper'

describe "Select 2", type: :feature do
  def create_invoice_with_categories
    Category.where(name: 'Cat #1', description: "Desc 1").first_or_create!
    cat = Category.where(name: 'Cat #2', description: "Desc 2").first_or_create!
    Invoice.first_or_create!(category: cat)
  end

  context "Default" do
    before do
      register_form(Invoice) do |f|
        f.input :category
      end

      invoice = create_invoice_with_categories
      visit edit_admin_invoice_path(invoice)
    end

    it "shows select control as select 2", js: true do
      expect(page).to have_css("div.select2-container", count: 1)
    end
  end

  context "Tags" do
    context "with empty collection" do
      before do
        register_form(Invoice) do |f|
          f.input :number, as: :tags
        end

        invoice = Invoice.first_or_create!
        visit edit_admin_invoice_path(invoice)
      end

      it "adds new tags", js: true do
        find("div.select2-container").click
        input = find('.select2-input')
        input.set('Value 1')
        input.native.send_keys(:return)
        expect(page).to have_css("li.select2-search-choice", count: 1)
        input.set('Value 2')
        input.native.send_keys(:return)
        expect(page).to have_css("li.select2-search-choice", count: 2)
      end
    end

    context "with empty collection" do
      before do
        register_form(Invoice) do |f|
          f.input :number, as: :tags, collection: ["#111", "#222", "#333"]
        end

        invoice = Invoice.first_or_create!
        visit edit_admin_invoice_path(invoice)
      end

      it "adds new tags", js: true do
        find("div.select2-container").click
        expect(page).to have_css(".select2-result", count: 3)
      end
    end
  end

  context "Ajax search" do
    context "with basic config" do
      before do
        register_page(Category) {}

        register_form(Invoice, false) do |f|
          f.input :category_id, as: :search_select, url: admin_categories_path
        end

        invoice = create_invoice_with_categories
        visit edit_admin_invoice_path(invoice)
      end

      it "shows invoice category only on initial state", js: true do
        expect(page.text).to match(/Cat #2/)
        expect(page.text).not_to match(/Cat #1/)
      end

      it "shows other categories after search", js: true do
        find("div.select2-container").click
        find('.select2-input').set('Cat')
        expect(page).to have_css('.select2-results .select2-result', count: 2)
      end
    end

    context "searching by other attributes" do
      before do
        register_page(Category) {}

        register_form(Invoice, false) do |f|
          f.input :category_id, as: :search_select,
                                url: admin_categories_path,
                                fields: [:description]
        end

        invoice = create_invoice_with_categories
        visit edit_admin_invoice_path(invoice)
      end

      it "shows nothing looking for name (default)", js: true do
        find("div.select2-container").click
        find('.select2-input').set('Cat')
        expect(page).to_not have_css('.select2-results .select2-result')
      end

      it "shows results looking for description", js: true do
        find("div.select2-container").click
        find('.select2-input').set('Desc')
        expect(page).to have_css('.select2-results .select2-result', count: 2)
      end
    end

    context 'with class option' do
      before do
        register_page(Category) {}

        register_form(Invoice, false) do |f|
          f.input :category_id, as: :search_select, url: admin_categories_path, class: 'tester'
        end

        invoice = create_invoice_with_categories
        visit edit_admin_invoice_path(invoice)
      end

      it "hidden input with tester class", js: true do
        expect(page).to have_css('input.select2-ajax.tester', visible: false)
      end
    end

    context "with different display name" do
      before do
        register_page(Category) {}

        register_form(Invoice, false) do |f|
          f.input :category_id, as: :search_select,
                                url: admin_categories_path,
                                display_name: :shiny_name
        end

        invoice = create_invoice_with_categories
        visit edit_admin_invoice_path(invoice)
      end

      it "shows custom label)", js: true do
        find("div.select2-container").click
        find('.select2-input').set('Cat')
        expect(page).to have_css('.select2-container .select2-chosen', text: /My shiny Cat #2/)
      end
    end
  end
end
