require "rails_helper"

describe "Selected List Input", type: :feature do
  def expect_added_count(count)
    expect(page).to have_css(".selected-item", count: count)
  end

  def expect_to_add_item(item, items_count = 1, attribute = :name)
    value = item.send(attribute)
    pick_slimselect_entered_option(value)
    html_item = find(".selected-item#invoice_item_ids_#{item.id}")
    expect(html_item.text).to match(value)
    expect_added_count(items_count)
    sleep 0.5
  end

  def expect_to_remove_item(item, items_count = 0)
    find(".selected-item#invoice_item_ids_#{item.id}").click
    expect_added_count(items_count)
  end

  before do
    register_page(Item) {}
    create_items
  end

  context "with no selected items" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "adds new items", js: true do
      expect_added_count(0)
      expect_to_add_item(@item1, 1)
      expect_to_add_item(@item2, 2)
    end

    it "does not add repeated items", js: true do
      expect_to_add_item(@item1, 1)
      expect_to_add_item(@item1, 1)
    end

    it "removes items", js: true do
      expect_to_add_item(@item1, 1)
      expect_to_add_item(@item2, 2)
      expect_to_remove_item(@item1, 1)
      expect_to_remove_item(@item2, 0)
    end
  end

  context "with selected items" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list
      end

      visit edit_admin_invoice_path(create_invoice(items: Item.all))
    end

    it "loads saved items", js: true do
      expect_added_count(3)
    end
  end

  context "with custom url" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, url: "/admin/items"
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "adds new items", js: true do
      expect_to_add_item(@item1, 1)
    end
  end

  context "with custom response_root" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, response_root: "my_categories"
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "pass response root as input data" do
      expect_slimselect_data_option("response-root", "my_categories")
    end
  end

  context "setting select width" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, width: "200px"
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "changes input width" do
      expect_slimselect_data_option("width", "200px")
    end
  end

  context "searching by other attributes" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, display_name: :description, fields: [:description]
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows nothing looking for name (default)", js: true do
      fill_slimselect_input("Cat")
      expect_slimselect_options_count_to_eq(0)
    end

    it "shows results looking for description", js: true do
      fill_slimselect_input("Desc")
      expect_slimselect_options_count_to_eq(3)
    end

    it "shows custom label", js: true do
      expect_to_add_item(@item1, 1, :description)
    end
  end

  context "setting minimum input length" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, minimum_input_length: 5
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows length message", js: true do
      fill_slimselect_input("A")
      expect_slimselect_error("Please enter 5 or more characters")
    end
  end

  context "with different order" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, order_by: :name_desc
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows results ordered by name DESC", js: true do
      fill_slimselect_input("Item")
      expect_slimselect_result_text_to_eq(1, @item3.name)
    end
  end

  context "with different predicate" do
    before do
      register_form(Invoice, false) do |f|
        f.input :item_ids, as: :selected_list, order_by: :name_desc, predicate: :end
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "does not show any result when searched with prefix", js: true do
      fill_slimselect_input("Item")
      expect_slimselect_options_count_to_eq(0)
    end

    it "shows results when searched with suffix", js: true do
      fill_slimselect_input("2")
      expect_slimselect_result_text_to_eq(1, @item2.name)
    end
  end
end
