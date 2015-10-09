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
        wait_for_ajax
        expect(page.text).to match(/Cat #2/)
        expect(page.text).to match(/Cat #1/)
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
        wait_for_ajax
        expect(page.text).not_to match(/Cat #1/)
      end

      it "shows results looking for description", js: true do
        find("div.select2-container").click
        find('.select2-input').set('Desc')
        wait_for_ajax
        expect(page.text).to match(/Cat #2/)
        expect(page.text).to match(/Cat #1/)
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
        wait_for_ajax
        expect(page.text).to match(/My shiny Cat #2/)
      end
    end
  end
end
