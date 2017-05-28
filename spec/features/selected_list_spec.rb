require "rails_helper"

describe "Selected List", type: :feature do
  def create_items
    items = []
    3.times.each { |idx| items << Item.where(name: "Item #{idx + 1}").first_or_create! }
    items
  end

  def expect_added_count(count)
    expect(page).to have_css(".selected-item", count: count)
  end

  def expect_to_add_item(item_name, items_count = 1)
    find("div.select2-container").click
    find(".select2-input").set(item_name)
    find(".select2-match").click

    item = Item.find_by(name: item_name)

    html_item = find(".selected-item#invoice_item_ids_#{item.id}")
    expect(html_item.text).to match(item_name)
    expect_added_count(items_count)
  end

  def expect_to_remove_item(item_name, items_count = 0)
    item = Item.find_by(name: item_name)

    html_item = find(".selected-item#invoice_item_ids_#{item.id}")
    html_item.click

    expect_added_count(items_count)
  end

  context "with no selected items" do
    before do
      register_form(Invoice, true) do |f|
        f.input :item_ids, as: :selected_list
      end

      register_page(Item, false) {}

      create_items
      invoice = Invoice.first_or_create!
      visit edit_admin_invoice_path(invoice)
    end

    it "adds new items", js: true do
      expect_added_count(0)
      expect_to_add_item("Item 1", 1)
      expect_to_add_item("Item 2", 2)
    end

    it "does not add repeated items", js: true do
      expect_to_add_item("Item 1", 1)
      expect_to_add_item("Item 1", 1)
    end

    it "removes items", js: true do
      expect_to_add_item("Item 1", 1)
      expect_to_add_item("Item 2", 2)
      expect_to_remove_item("Item 1", 1)
      expect_to_remove_item("Item 2", 0)
    end
  end

  context "with selected items" do
    before do
      register_form(Invoice, true) do |f|
        f.input :item_ids, as: :selected_list
      end

      register_page(Item, false) {}

      items = create_items
      invoice = Invoice.first_or_create!
      invoice.item_ids = [items.first.id]
      visit edit_admin_invoice_path(invoice)
    end

    it "loads saved items", js: true do
      expect_added_count(1)
    end
  end
end
