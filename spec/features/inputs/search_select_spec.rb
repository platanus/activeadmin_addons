require "rails_helper"

describe "Search Select", type: :feature do
  before do
    register_page(Category) {}

    create_categories
    create_invoice(category: @category2)
  end

  context "with basic config" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows invoice category only on initial state", js: true do
      expect(page.text).to match(/#{@category2.name}/)
      expect(page.text).not_to match(/#{@category1.name}/)
    end

    it "shows other categories after search", js: true do
      fill_select2_input("Cat")
      expect_select2_results_count_to_eq(2)
    end
  end

  context "searching by other attributes" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, fields: [:description]
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows nothing looking for name (default)", js: true do
      fill_select2_input("Cat")
      expect_select2_results_count_to_eq(0)
    end

    it "shows results looking for description", js: true do
      fill_select2_input("Desc")
      expect_select2_results_count_to_eq(2)
    end
  end

  context "with class option" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, class: "tester"
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "hidden input with tester class", js: true do
      expect(page).to have_css("select.search-select.tester", visible: false)
    end
  end

  context "with different display name" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, display_name: :description
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows custom label", js: true do
      pick_select2_entered_option("Cat", @category1.description)
      expect_select2_selection(@category1.description)
    end
  end

  context "with different order" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, order_by: :name_desc
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows results ordered by name DESC", js: true do
      fill_select2_input("Cat")
      expect_select2_result_text_to_eq(1, @category2.name)
    end
  end
end
