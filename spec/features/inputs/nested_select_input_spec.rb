require "rails_helper"

describe "Nested Select Input", type: :feature do
  context "with nil city" do
    before do
      register_form(Invoice, false) do |f|
        f.input :city_id, as: :nested_select,
                          level_1: {
                            attribute: :country_id,
                            width: "30px"
                          },
                          level_2: {
                            attribute: :region_id,
                            url: "/fakeurl",
                            response_root: "my_regions"
                          },
                          level_3: {
                            attribute: :city_id
                          }
      end

      visit edit_admin_invoice_path(create_invoice)
    end

    it "shows empty select controls" do
      expect(page.text).to_not match(/Chile/)
      expect(page.text).to_not match(/Metropolitana/)
      expect(page.text).to_not match(/Santiago/)
    end

    it "uses the custom url" do
      expect(page.html).to match('fakeurl')
    end

    it "changes input width" do
      on_input_ctx("invoice_region_id") { expect_select2_data_option("width", "30px") }
    end

    it "changes input width" do
      on_input_ctx("invoice_region_id") do
        expect_select2_data_option("response-root", "my_regions")
      end
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

      create_cities
      create_invoice(city: @santiago)
      visit edit_admin_invoice_path(@invoice)
    end

    it "shows filled select controls based on defined city_id", js: true do
      on_input_ctx("invoice_country_id") { expect_select2_selection("Chile") }
      on_input_ctx("invoice_region_id") { expect_select2_selection("Metropolitana") }
      on_input_ctx("invoice_city_id") { expect_select2_selection("Santiago") }
    end

    context "updating the highest hierachy level" do
      before do
        on_input_ctx("invoice_country_id") { open_select2_options }
        select2_input.set("Arg")
      end

      it "shows results based on entered text", js: true do
        expect_select2_result_text_to_eq(1, "Argentina")
      end

      context "after click option" do
        before { click_select2_option("Argentina") }

        it "sets value", js: true do
          on_input_ctx("invoice_country_id") { expect_select2_selection("Argentina") }
        end

        it "resets children select controls after click option", js: true do
          on_input_ctx("invoice_region_id") { expect_select2_empty_selection }
          on_input_ctx("invoice_city_id") { expect_select2_empty_selection }
        end
      end
    end

    context "updating medium level" do
      before do
        on_input_ctx("invoice_region_id") { open_select2_options }
        select2_input.set("Antof")
      end

      it "shows results based on entered text", js: true do
        expect_select2_result_text_to_eq(1, "Antofagasta")
      end

      context "after click option" do
        before { click_select2_option("Antofagasta") }

        it "sets value", js: true do
          on_input_ctx("invoice_region_id") { expect_select2_selection("Antofagasta") }
        end

        it "preserves parent value", js: true do
          on_input_ctx("invoice_country_id") { expect_select2_selection("Chile") }
        end

        it "resets children values", js: true do
          on_input_ctx("invoice_city_id") { expect_select2_empty_selection }
        end
      end
    end

    context "updating lowest level" do
      before do
        on_input_ctx("invoice_city_id") { open_select2_options }
        select2_input.set("na")
      end

      it "shows results based on entered text", js: true do
        expect_select2_result_text_to_eq(1, "Colina")
      end

      context "after click option", js: true do
        before { click_select2_option("Colina") }

        it "sets value", js: true do
          on_input_ctx("invoice_city_id") { expect_select2_selection("Colina") }
        end

        it "preserves parent values", js: true do
          on_input_ctx("invoice_country_id") { expect_select2_selection("Chile") }
          on_input_ctx("invoice_region_id") { expect_select2_selection("Metropolitana") }
        end
      end
    end

    context "with general options" do
      before do
        register_page(Region, false) {}
        register_page(City, false) {}

        register_form(Invoice, false) do |f|
          f.input :city_id, as: :nested_select,
                            fields: [:name, :information],
                            display_name: :id,
                            minimum_input_length: 5,
                            level_1: { attribute: :region_id },
                            level_2: { attribute: :city_id }
        end

        create_cities
        create_invoice(city: @santiago)
        visit edit_admin_invoice_path(@invoice)
      end

      it "sets display name on each select", js: true do
        on_input_ctx("invoice_region_id") { expect_select2_selection(@metropolitana.id) }
        on_input_ctx("invoice_city_id") { expect_select2_selection(@santiago.id) }
      end

      it "sets general minimum_input_length option", js: true do
        msg = "Please enter 5 or more characters"
        on_input_ctx("invoice_region_id") { open_select2_options }
        expect_select2_result_text_to_eq(1, msg)
        on_input_ctx("invoice_region_id") { select2_options_container.click }
        on_input_ctx("invoice_city_id") { open_select2_options }
        expect_select2_result_text_to_eq(1, msg)
      end

      it "uses general fields to search", js: true do
        on_input_ctx("invoice_city_id") { open_select2_options }
        select2_input.set("info1")
        expect_select2_result_text_to_eq(1, @santiago.id)
      end
    end
  end
  context "with filters"  do
    before do
      register_page(Country, false) {}
      register_page(Region, false) {}
      register_page(City, false) {}

      register_form(Invoice, false) do |f|
        f.input :city_id, as: :nested_select,
                          level_1: { attribute: :country_id },
                          level_2: {
                            attribute: :region_id,
                            filters: { name_contains: 'Met' }
                            },
                          level_3: { attribute: :city_id }
      end

      create_cities
      create_invoice(city: @colina)
      visit edit_admin_invoice_path(@invoice)
    end

    it "shows filled select controls based on defined city_id", js: true do
      on_input_ctx("invoice_country_id") { expect_select2_selection("Chile") }
      on_input_ctx("invoice_region_id") { expect_select2_selection("Metropolitana") }
      on_input_ctx("invoice_city_id") { expect_select2_selection("Colina") }
    end

    context "updating medium level" do
      before do
        on_input_ctx("invoice_region_id") { open_select2_options }
        select2_input.set("a")
      end

      it "shows no results based on entered text", js: true do
        expect_select2_results_count_to_eq(1)
      end
    end
  end

  context "without filters"  do
    before do
      register_page(Country, false) {}
      register_page(Region, false) {}
      register_page(City, false) {}

      register_form(Invoice, false) do |f|
        f.input :city_id, as: :nested_select,
                          level_1: { attribute: :country_id },
                          level_2: { attribute: :region_id },
                          level_3: { attribute: :city_id }
      end

      create_cities
      create_invoice(city: @colina)
      visit edit_admin_invoice_path(@invoice)
    end

    it "shows filled select controls based on defined city_id", js: true do
      on_input_ctx("invoice_country_id") { expect_select2_selection("Chile") }
      on_input_ctx("invoice_region_id") { expect_select2_selection("Metropolitana") }
      on_input_ctx("invoice_city_id") { expect_select2_selection("Colina") }
    end

    context "updating medium level" do
      before do
        on_input_ctx("invoice_region_id") { open_select2_options }
        select2_input.set("a")
      end

      it "shows no results based on entered text", js: true do
        expect_select2_results_count_to_eq(2)
      end
    end
  end

  context "with nested resources" do
    before do
      register_page(Region, false) {}
      register_page(Country, false) {}
      register_page(City, false) {}

      register_form(Department, false) do |f|
        f.has_many :departments_cities, allow_destroy: true do |city|
          city.input :city_id, as: :nested_select, required: true,
                               display_name: :id,
                               minimum_input_length: 0,
                               level_1: { attribute: :country_id },
                               level_2: { attribute: :region_id },
                               level_3: { attribute: :city_id }
        end
      end
      create_cities
      visit new_admin_department_path
    end

    it "sets new values correctly", js: true do
      click_add_nested
      prefix = "department_departments_cities_attributes_"
      santiago = @santiago.id
      on_nested_ctx(1) do
        on_input_ctx("#{prefix}0_country_id") do
          open_select2_options
          click_select2_option(@chile.id)
        end
        on_input_ctx("#{prefix}0_region_id") do
          open_select2_options
          click_select2_option(@metropolitana.id)
        end
        on_input_ctx("#{prefix}0_city_id") do
          open_select2_options
          click_select2_option(santiago)
        end
        expect_nested_select2_result_text_to_eq(3, santiago)
      end

      click_add_nested
      on_nested_ctx(2) do
        mendoza = @mendoza.id
        on_input_ctx("#{prefix}1_country_id") do
          open_select2_options
          click_select2_option(@argentina.id)
        end
        on_input_ctx("#{prefix}1_region_id") do
          open_select2_options
          click_select2_option(@cuyo.id)
        end
        on_input_ctx("#{prefix}1_city_id") do
          open_select2_options
          click_select2_option(mendoza)
        end
        expect_nested_select2_result_text_to_eq(3, mendoza)
      end

      on_nested_ctx(1) do
        expect_nested_select2_result_text_to_eq(3, santiago)
      end
    end
  end
end
