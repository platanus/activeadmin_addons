require "rails_helper"

describe "Select Filter Input", type: :feature do
  context 'when used with an enum column' do
    let!(:active_invoice) { Invoice.create!(status: :active) }
    let!(:archived_invoice) { Invoice.create!(status: :archived) }
    let(:option_selector) { '.filter_form select[name="q[status_eq]"] option' }

    context "with collection option" do
      before do
        register_page(Invoice) do
          filter :status, as: :select, collection: [
            ['Activo, si se considera', 0],
            ['Archivado, ya no se considera', 1],
            ['Estado que no existe', 42]
          ]
        end

        visit admin_invoices_path
      end

      it "uses collection directly" do
        expect(page.find("#{option_selector}[value='0']").text).to eq('Activo, si se considera')
        expect(page.find("#{option_selector}[value='1']").text).to(
          eq('Archivado, ya no se considera')
        )
        expect(page.find("#{option_selector}[value='42']").text).to eq('Estado que no existe')
      end

      it 'displays all records' do
        expect(page).to have_css('.col-id', text: /#{active_invoice.id}/)
        expect(page).to have_css('.col-id', text: /#{archived_invoice.id}/)
      end

      context 'when selecting a value', js: true do
        before do
          pick_slimselect_entered_option('Activo, si se considera')
          click_filter_btn
        end

        it 'displays only elements with that value' do
          expect(page).to have_css('.col-id', text: /#{active_invoice.id}/)
          expect(page).not_to have_css('.col-id', text: /#{archived_invoice.id}/)
        end
      end
    end

    context "without collection option" do
      before do
        register_page(Invoice) do
          filter :status, as: :select
        end

        visit admin_invoices_path
      end

      it "renders options with enum db values and translated labels" do
        expect(page.find("#{option_selector}[value='0']").text).to eq('Activo')
        expect(page.find("#{option_selector}[value='1']").text).to eq('Archivado')
      end

      it 'displays all records' do
        expect(page).to have_css('.col-id', text: /#{active_invoice.id}/)
        expect(page).to have_css('.col-id', text: /#{archived_invoice.id}/)
      end

      context 'when selecting a value', js: true do
        before do
          pick_slimselect_entered_option('Archivado')
          click_filter_btn
        end

        it 'displays only elements with that value' do
          expect(page).to have_css('.col-id', text: /#{archived_invoice.id}/)
          expect(page).not_to have_css('.col-id', text: /#{active_invoice.id}/)
        end
      end
    end
  end
end
