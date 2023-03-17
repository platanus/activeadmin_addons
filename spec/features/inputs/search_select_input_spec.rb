require "rails_helper"

describe "Search Select Input", type: :feature do
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

    it "shows invoice category only on initial state" do
      expect(page.text).to match(/#{@category2.name}/)
      expect(page.text).not_to match(/#{@category1.name}/)
    end

    it "shows other categories after search", js: true do
      fill_slimselect_input("Cat")
      expect_slimselect_options_count_to_eq(2)
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
      fill_slimselect_input("Cat")
      expect_slimselect_options_count_to_eq(0)
    end

    it "shows results looking for description", js: true do
      fill_slimselect_input("Desc")
      expect_slimselect_options_count_to_eq(2)
    end
  end

  context "with custom url" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, url: "/admin/categories"
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows other categories after search", js: true do
      fill_slimselect_input("Cat")
      expect_slimselect_options_count_to_eq(2)
    end
  end

  context "with custom response_root" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, response_root: "my_categories"
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "pass response root as input data" do
      expect_slimselect_data_option("response-root", "my_categories")
    end
  end

  context "setting minimum input length" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, minimum_input_length: 5
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "shows length message", js: true do
      fill_slimselect_input("a")
      expect_slimselect_error("Please enter 5 or more characters")
    end
  end

  context "setting select width" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, width: "200px"
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "changes input width" do
      expect_slimselect_data_option("width", "200px")
    end
  end

  context "with class option" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, class: "tester"
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "hidden input with tester class" do
      expect(page).to have_css("select.search-select-input.tester", visible: false)
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
      pick_slimselect_entered_option("Cat", @category1.description)
      expect_slimselect_selection(@category1.description)
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
      fill_slimselect_input("Cat")
      expect_slimselect_result_text_to_eq(1, @category2.name)
    end
  end

  context "with different predicate" do
    before do
      register_form(Invoice, false) do |f|
        f.input :category_id, as: :search_select, predicate: :end
      end

      visit edit_admin_invoice_path(@invoice)
    end

    it "does not show any result when searched with prefix", js: true do
      fill_slimselect_input("Cat")
      expect_slimselect_options_count_to_eq(0)
    end

    it "shows results when searched with suffix", js: true do
      fill_slimselect_input("2")
      expect_slimselect_result_text_to_eq(1, @category2.name)
    end
  end
end
