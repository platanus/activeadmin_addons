require "rails_helper"

describe "Selected List", type: :feature do
  def expect_added_count(count)
    expect(page).to have_css(".selected-item", count: count)
  end

  def expect_to_add_item(item, items_count = 1)
    pick_select2_entered_option(item.name)
    html_item = find(".selected-item#invoice_item_ids_#{item.id}")
    expect(html_item.text).to match(item.name)
    expect_added_count(items_count)
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
end
