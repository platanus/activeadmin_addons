require "rails_helper"

describe "Search Select Filter Input", type: :feature do
  before do
    register_page(Region) {}

    create_cities
  end

  context "with initial state" do
    before do
      register_page(City, false) do
        filter :region, as: :search_select_filter
      end

      visit admin_cities_path
    end

    it "shows filter input" do
      expect_css("select#q_region_id")
    end

    it "shows all the results" do
      within "#index_table_cities" do
        expect_text("Santiago")
        expect_text("Colina")
        expect_text("Mejillones")
        expect_text("Tocopilla")
        expect_text("Mendoza")
      end
    end

    context "setting value", js: true do
      before do
        pick_slimselect_entered_option("Metropolitana")
        click_filter_btn
      end

      it "shows all the results" do
        within "#index_table_cities" do
          expect_text("Santiago")
          expect_text("Colina")
          not_expect_text("Mejillones")
          not_expect_text("Tocopilla")
          not_expect_text("Mendoza")
        end
      end
    end
  end
end
