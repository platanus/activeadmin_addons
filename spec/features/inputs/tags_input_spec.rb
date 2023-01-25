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

  context "working with active record relations" do
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

      it "adds/removes hidden item", js: true do
        item_id = "#invoice_item_ids_#{@item1.id}"
        input = find(item_id, visible: false)
        expect(input.value).to eq(@item1.id.to_s)
        expect(input[:name]).to eq("invoice[item_ids][]")
        find(".ss-value-delete").click
        sleep 0.5
        expect { find(item_id, visible: false) }.to raise_error(Capybara::ElementNotFound)
      end

      it "does not allow new items", js: true do
        expect_slimselect_options_count_to_eq(3)
        expect { add_slimselect_option("Not preloaded item") }.to raise_error(Capybara::ElementNotFound)
        slimselect_element.send_keys(:escape)
        expect_slimselect_options_count_to_eq(3)
      end
    end
  end

  context "working with active record relations but alias" do
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

      it "adds/removes hidden item", js: true do
        item_id = "#invoice_other_item_ids_#{@item1.id}"
        input = find(item_id, visible: false)
        expect(input.value).to eq(@item1.id.to_s)
        expect(input[:name]).to eq("invoice[other_item_ids][]")
        find(".ss-value-delete").click
        sleep 0.5
        expect { find(item_id, visible: false) }.to raise_error(Capybara::ElementNotFound)
      end
    end
  end
end
