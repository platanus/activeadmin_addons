require "rails_helper"

describe "STI Resource", type: :feature do
  context "Child resource", js: true  do
    before do
      register_form(Cat) do
        input :group_ids, as: :selected_list
      end
    end

    def group_ids_field
      'input[name="cat[group_ids][]"]'
    end

    context "Create" do
      before do
        visit new_admin_cat_path
      end

      it "renders group ids input" do
        expect(page).to have_css(group_ids_field, visible: false)
      end
    end

    context "Edit" do
      before do
        @cat = Cat.create
        visit edit_admin_cat_path(@cat)
      end

      it "renders group ids input" do
        expect(page).to have_css(group_ids_field, visible: false)
      end
    end
  end

  context "Parent resource", js: true  do
    before do
      register_form(Animal) do
        input :group_ids, as: :selected_list
      end
    end

    def group_ids_input_name
      'input[name="animal[group_ids][]"]'
    end

    context "Create" do
      before do
        visit new_admin_animal_path
      end

      it "renders group ids input" do
        expect(page).to have_css(group_ids_input_name, visible: false)
      end
    end

    context "Edit" do
      before do
        @cat = Cat.create
        visit edit_admin_animal_path(@cat)
      end

      it "renders group ids input" do
        expect(page).to have_css(group_ids_input_name, visible: false)
      end
    end
  end
end
