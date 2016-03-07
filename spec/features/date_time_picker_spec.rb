require "rails_helper"

describe "Date Time Picker", type: :feature do
  context "Form", js: true do
    def picker_input
      find("#invoice_updated_at")
    end

    context "with defaults" do
      before do
        register_page(Invoice) do
          form do |f|
            f.input :updated_at, as: :date_time_picker
            f.actions
          end
        end

        visit new_admin_invoice_path
      end

      it "shows date time picker"do
        expect(page).to have_css(".date-time-picker", count: 1)
      end
    end

    context "passing options" do
      before do
        register_page(Invoice) do
          form do |f|
            f.input :updated_at, as: :date_time_picker,
                                 picker_options: {
                                   today_button: true,
                                   allow_times: [
                                     '12:10', '13:10', '15:10',
                                     '17:10', '18:10', '19:10'
                                   ]
                                 }
            f.actions
          end
        end

        visit new_admin_invoice_path
      end

      it "applies given options"do
        picker_input.click
        expect(page).to have_css(".xdsoft_time_variant .xdsoft_time", count: 6)
        expect(page).to have_css(".xdsoft_today_button", count: 1)
      end
    end

    context "overriding default options" do
      before do
        datetime_picker_input = Formtastic::Inputs::StringInput::DateTimePickerInput

        # This if for front-end javascript side
        datetime_picker_input.default_datetime_picker_options = {
          today_button: false,
          format: "d-m-Y H:i"
        }

        # This if for backend (Ruby)
        datetime_picker_input.format = "%d-%m-%Y %H:%M"

        register_page(Invoice) do
          form do |f|
            f.input :updated_at, as: :date_time_picker
            f.actions
          end
        end

        @invoice = Invoice.first_or_create!
        visit edit_admin_invoice_path(@invoice)
      end

      it "applies default options"do
        expect(picker_input.value).to eq(@invoice.updated_at.strftime("%d-%m-%Y %H:%M"))
        picker_input.click
        expect(page).to_not have_css(".xdsoft_today_button", count: 1)
      end
    end
  end
end
