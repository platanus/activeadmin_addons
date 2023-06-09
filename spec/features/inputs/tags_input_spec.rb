require "rails_helper"

describe "Tags Input", type: :feature do
  context "with empty collection" do
    before do
      register_form(Invoice) do |f|
        f.input :number, as: :tags
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "adds new tags", js: true do
      add_slimselect_option("value 1")
      open_slimselect_options
      expect_slimselect_options_count_to_eq(1)
      add_slimselect_option("value 2")
      open_slimselect_options
      expect_slimselect_options_count_to_eq(2)
    end
  end

  context "with non empty collection" do
    before do
      register_form(Invoice) do |f|
        f.input :number, as: :tags, collection: ["#111", "#222", "#333"]
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "adds new tags", js: true do
      expect_slimselect_options_count_to_eq(3)
    end
  end

  context "when working with active record relations" do
    before do
      register_form(Invoice) do |f|
        f.input :item_ids, as: :tags, collection: Item.all
      end

      create_items
      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows preloaded items", js: true do
      expect_slimselect_options_count_to_eq(3)
    end

    context "with added item" do
      before { pick_slimselect_entered_option(@item1.name) }

      it "includes and then removes item from select value", js: true do
        select_selector = "select[name='invoice[item_ids][]']"
        expect(find(select_selector, visible: false).value).to include(@item1.id.to_s)
        find(".ss-value-delete").click
        sleep 0.5
        expect(find(select_selector, visible: false).value).not_to include(@item1.id.to_s)
      end

      it "does not allow new items", js: true do
        expect_slimselect_options_count_to_eq(3)
        expect do
          add_slimselect_option("Not preloaded item")
        end.to raise_error(Capybara::ElementNotFound)
        slimselect_element.send_keys(:escape)
        expect_slimselect_options_count_to_eq(3)
      end
    end
  end

  context "when working with active record relations but alias" do
    before do
      register_form(Invoice) do |f|
        f.input :other_item_ids, as: :tags, collection: Item.all
      end

      create_items
      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows preloaded items", js: true do
      expect_slimselect_options_count_to_eq(3)
    end

    context "with added item" do
      before { pick_slimselect_entered_option(@item1.name) }

      it "includes and then removes item from select value", js: true do
        select_selector = "select[name='invoice[other_item_ids][]']"
        expect(find(select_selector, visible: false).value).to include(@item1.id.to_s)
        find(".ss-value-delete").click
        sleep 0.5
        expect(find(select_selector, visible: false).value).not_to include(@item1.id.to_s)
      end
    end
  end
end
