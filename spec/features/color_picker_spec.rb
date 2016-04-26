require "rails_helper"

describe "Color Picker", type: :feature do
  context "Form", js: true  do
    def picker_btn
      find("div[data-target=\"invoice[color]\"]")
    end

    def selected_color_box(hex)
      find("span[data-color=\"#{hex}\"]")
    end

    def color_input
      find("#invoice_color", visible: false)
    end

    context "with default palette" do
      before do
        register_page(Invoice) do
          form do |f|
            f.inputs "Details" do
              f.input :color, as: :color_picker
            end

            f.actions
          end
        end

        visit new_admin_invoice_path
      end

      it "shows color picker btn" do
        expect(picker_btn[:class]).to eq("palette-color-picker-button")
      end

      context "selecting a color" do
        before do
          picker_btn.click
          selected_color_box("#663300").click
        end

        it "shows color icon" do
          expect(color_input.value).to eq("#663300")
        end

        context "removing selected color" do
          before do
            picker_btn.click
            find(".swatch.clear").click
          end

          it "removes selected color" do
            expect(color_input.value).to eq("")
          end
        end
      end
    end

    context "with custom palette" do
      before do
        register_page(Invoice) do
          form do |f|
            f.inputs "Details" do
              f.input :color, as: :color_picker, palette: ["#FF9900"]
            end

            f.actions
          end
        end

        visit new_admin_invoice_path
        picker_btn.click
      end

      it "shows custom palette" do
        expect(page).to have_css(".swatch", count: 2)
      end
    end
  end
end
