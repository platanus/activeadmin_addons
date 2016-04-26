require "rails_helper"

describe "Select 2", type: :feature do
  def create_invoice_with_categories
    Category.where(name: "Cat #1", description: "Desc 1").first_or_create!
    cat = Category.where(name: "Cat #2", description: "Desc 2").first_or_create!
    Invoice.first_or_create!(category: cat)
  end

  def create_invoice_with_city
    chile = Country.where(name: "Chile").first_or_create!
    @metropolitana = Region.where(name: "Metropolitana", country: chile).first_or_create!
    @santiago = City.where(
      name: "Santiago", region: @metropolitana, information: "info1").first_or_create!
    City.where(name: "Colina", region: @metropolitana).first_or_create!
    antofagasta = Region.where(name: "Antofagasta", country: chile).first_or_create!
    City.where(name: "Mejillones", region: antofagasta).first_or_create!
    City.where(name: "Tocopilla", region: antofagasta).first_or_create!

    argentina = Country.where(name: "Argentina").first_or_create!
    cuyo = Region.where(name: "Cuyo", country: argentina).first_or_create!
    City.where(name: "Mendoza", region: cuyo).first_or_create!

    Invoice.first_or_create!(city: @santiago)
  end

  def create_items
    3.times.each do |idx|
      Item.where(name: "Item #{idx + 1}").first_or_create!
    end
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
        input = find(".select2-input")
        input.set("Value 1")
        input.native.send_keys(:return)
        expect(page).to have_css("li.select2-search-choice", count: 1)
        input.set("Value 2")
        input.native.send_keys(:return)
        expect(page).to have_css("li.select2-search-choice", count: 2)
      end
    end

    context "with non empty collection" do
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

    context "working with active record relations" do
      before do
        register_form(Invoice) do |f|
          f.input :item_ids, as: :tags, collection: Item.all
        end

        invoice = Invoice.first_or_create!
        create_items
        visit edit_admin_invoice_path(invoice)
      end

      it "shows preloaded items", js: true do
        find("div.select2-container").click
        expect(page).to have_css(".select2-result", count: 3)
      end

      context "with added item" do
        before do
          find("div.select2-container").click
          @first_item = Item.first
          @input = find(".select2-input")
          @input.set(@first_item.name)
          @input.native.send_keys(:return)
        end

        it "adds/removes hidden item", js: true do
          item_id = "#invoice_item_ids_#{@first_item.id}"
          input = find(item_id, visible: false)
          expect(input.value).to eq(@first_item.id.to_s)
          expect(input[:name]).to eq("invoice[item_ids][]")
          remove_item_btn = find(".select2-search-choice-close")
          remove_item_btn.native.send_keys(:return)
          expect { find(item_id, visible: false) }.to raise_error
        end

        it "does not allow new items", js: true do
          expect(page).to have_css("li.select2-search-choice", count: 1)
          @input.set("Not preloaded item")
          @input.native.send_keys(:return)
          expect(page).to have_css("li.select2-search-choice", count: 1)
        end
      end
    end
  end

  context "Nested select" do
    context "with nil city" do
      before do
        register_form(Invoice, false) do |f|
          f.input :city_id, as: :nested_select,
                            level_1: { attribute: :country_id },
                            level_2: { attribute: :region_id, url: "/fakeurl" },
                            level_3: { attribute: :city_id }
        end

        invoice = Invoice.first_or_create!
        visit edit_admin_invoice_path(invoice)
      end

      it "shows empty select controls", js: true do
        expect(page.text).to_not match(/Chile/)
        expect(page.text).to_not match(/Metropolitana/)
        expect(page.text).to_not match(/Santiago/)
      end

      it "uses the custom url" do
        expect(page.html).to match('fakeurl')
      end
    end

    context "with selected city" do
      before do
        register_page(Country, false) {}
        register_page(Region, false) {}
        register_page(City, false) {}

        register_form(Invoice, false) do |f|
          f.input :city_id, as: :nested_select,
                            level_1: { attribute: :country_id },
                            level_2: {
                              attribute: :region_id,
                              collection: Region.all
                            },
                            level_3: { attribute: :city_id }
        end

        invoice = create_invoice_with_city
        visit edit_admin_invoice_path(invoice)
      end

      it "shows filled select controls based on defined city_id", js: true do
        expect(page).to have_css("#s2id_invoice_country_id .select2-chosen", text: /Chile/)
        expect(page).to have_css("#s2id_invoice_region_id .select2-chosen", text: /Metropolitana/)
        expect(page).to have_css("#s2id_invoice_city_id .select2-chosen", text: /Santiago/)
      end

      context "updating the highest hierachy level" do
        before do
          find("#s2id_invoice_country_id").click
          find(".select2-input").set("Arg")
        end

        it "shows results based on entered text", js: true do
          expect(page).to have_css(".select2-results .select2-result", count: 1, text: /Argentina/)
        end

        context "after click option" do
          before { find(".select2-result-label").click }

          it "sets value after click option", js: true do
            expect(page).to have_css("#s2id_invoice_country_id .select2-chosen", text: /Argentina/)
          end

          it "resets children select controls after click option", js: true do
            expect(page.text).to_not match(/Metropolitana/)
            expect(page.text).to_not match(/Santiago/)
          end
        end
      end

      context "updating medium level" do
        before do
          find("#s2id_invoice_region_id").click
          find(".select2-input").set("Antof")
        end

        it "shows results based on entered text", js: true do
          expect(page).to have_css(".select2-results .select2-result",
            count: 1, text: /Antofagasta/)
        end

        context "after click option" do
          before { find(".select2-result-label").click }

          it "sets value after click option", js: true do
            expect(page).to have_css("#s2id_invoice_region_id .select2-chosen", text: /Antofagasta/)
          end

          it "preserves parent value", js: true do
            expect(page).to have_css("#s2id_invoice_country_id .select2-chosen", text: /Chile/)
          end

          it "resets children values", js: true do
            expect(page.text).to_not match(/Santiago/)
          end
        end
      end

      context "updating lowest level" do
        before do
          find("#s2id_invoice_city_id").click
          find(".select2-input").set("na")
        end

        it "shows results based on entered text", js: true do
          expect(page).to have_css(".select2-results .select2-result", count: 1, text: /Colina/)
        end

        context "after click option", js: true do
          before { find(".select2-result-label").click }

          it "sets value after click option", js: true do
            expect(page).to have_css("#s2id_invoice_city_id .select2-chosen", text: /Colina/)
          end

          it "preserves parent values", js: true do
            expect(page).to have_css("#s2id_invoice_country_id .select2-chosen", text: /Chile/)
            expect(page).to have_css("#s2id_invoice_region_id .select2-chosen",
              text: /Metropolitana/)
          end
        end
      end

      context "with general options" do
        before do
          register_page(Region, false) {}
          register_page(City, false) {}

          register_form(Invoice, false) do |f|
            f.input :city_id, as: :nested_select,
                              fields: [:name, :information], display_name: :id,
                              minimum_input_length: 5,
                              level_1: { attribute: :region_id },
                              level_2: { attribute: :city_id }
          end

          invoice = create_invoice_with_city
          visit edit_admin_invoice_path(invoice)
        end

        it "sets display name on each select", js: true do
          expect(page).to have_css("#s2id_invoice_region_id .select2-chosen",
            text: /#{@metropolitana.id}/)
          expect(page).to have_css("#s2id_invoice_city_id .select2-chosen",
            text: /#{@santiago.id}/)
        end

        it "sets general minimum_input_length option", js: true do
          find("#s2id_invoice_region_id").click
          expect(page).to have_css(".select2-no-results",
            text: /Please enter 5 or more characters/)
          find("#s2id_invoice_city_id").click
          expect(page).to have_css(".select2-no-results",
            text: /Please enter 5 or more characters/)
        end

        it "uses general fields to search", js: true do
          find("#s2id_invoice_city_id").click
          find(".select2-input").set("info1")
          expect(page).to have_css("#s2id_invoice_city_id .select2-chosen",
            text: /#{@santiago.id}/)
        end
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
        find(".select2-input").set("Cat")
        expect(page).to have_css(".select2-results .select2-result", count: 2)
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
        find(".select2-input").set("Cat")
        expect(page).to_not have_css(".select2-results .select2-result")
      end

      it "shows results looking for description", js: true do
        find("div.select2-container").click
        find(".select2-input").set("Desc")
        expect(page).to have_css(".select2-results .select2-result", count: 2)
      end
    end

    context "with class option" do
      before do
        register_page(Category) {}

        register_form(Invoice, false) do |f|
          f.input :category_id, as: :search_select, url: admin_categories_path, class: "tester"
        end

        invoice = create_invoice_with_categories
        visit edit_admin_invoice_path(invoice)
      end

      it "hidden input with tester class", js: true do
        expect(page).to have_css("input.select2-ajax.tester", visible: false)
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

      it "shows custom label", js: true do
        find("div.select2-container").click
        find(".select2-input").set("Cat")
        expect(page).to have_css(".select2-container .select2-chosen", text: /My shiny Cat #2/)
      end
    end
  end
end
