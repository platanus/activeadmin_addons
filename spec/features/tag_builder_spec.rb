require 'rails_helper'

describe "Tag Builder", type: :feature do
  context "using Enumerize" do
    context "changing state value" do
      before do
        register_index(Invoice) do
          tag_column :state
        end

        create_invoice(state: :approved)
        visit admin_invoices_path
      end

      it "shows set label" do
        expect(page).to have_content('Approved')
      end

      it "shows valid css class" do
        expect(page).to have_css('.approved')
      end
    end

    context "passing a block" do
      before do
        register_show(Invoice) do
          tag_row(:state) do
            invoice.state
          end
        end

        visit admin_invoice_path(create_invoice)
      end

      it "localizes the value returned from the block" do
        expect(page).to have_content('Pending')
      end

      it "shows valid css class" do
        expect(page).to have_css('.pending')
      end
    end

    context "using a label" do
      before do
        register_show(Invoice) do
          tag_row("custom state", :state)
        end

        visit admin_invoice_path(create_invoice)
      end

      it "shows custom label" do
        expect(page).to have_content 'Custom State'
      end
    end

    context 'with interactive option' do
      let!(:invoice) { create_invoice(state: :approved) }

      before do
        register_index(Invoice) do
          tag_column :state, interactive: true
        end

        visit admin_invoices_path
      end

      it "shows set label" do
        expect(page).to have_content('Approved')
      end

      it "shows valid css class" do
        expect(page).to have_css('.approved')
      end

      it 'shows interactive tag select container' do
        expect(page).to have_css('.tag-select-container')
      end

      it 'shows tag with required data' do
        expect(page).to have_css(".invoice-state-#{invoice.id}-tag")
        expect(page).to have_css('.interactive-tag[data-model="invoice"]')
        expect(page).to have_css(".interactive-tag[data-object_id=\"#{invoice.id}\"]")
        expect(page).to have_css('.interactive-tag[data-field="state"]')
        expect(page).to have_css('.interactive-tag[data-value="approved"]')
      end

      it 'select is hidden' do
        expect(page).to have_css('.interactive-tag-select')
        expect(page).to have_css('.select-container-hidden')
      end

      it 'shows select with required data' do
        expect(page).to have_css(".invoice-state-#{invoice.id}-select")
        expect(page).to have_css('.interactive-tag-select[data-model="invoice"]')
        expect(page).to have_css(".interactive-tag-select[data-object_id=\"#{invoice.id}\"]")
        expect(page).to have_css('.interactive-tag-select[data-field="state"]')
        expect(page).to have_css('.interactive-tag-select[data-value="approved"]')
      end
    end
  end

  context "using Rails Enum" do
    shared_examples 'interactive select rendering' do
      let!(:invoice) { create_invoice(status: :active) }

      before do
        register_index(Invoice) do
          tag_column :status, interactive: true
        end

        visit admin_invoices_path
      end

      it "shows set label" do
        expect(page).to have_content('Active')
      end

      it "shows valid css class" do
        expect(page).to have_css('.active')
      end

      it 'shows interactive tag select container' do
        expect(page).to have_css('.tag-select-container')
      end

      it 'shows tag with required data' do
        expect(page).to have_css(".invoice-status-#{invoice.id}-tag")
        expect(page).to have_css('.interactive-tag[data-model="invoice"]')
        expect(page).to have_css(".interactive-tag[data-object_id=\"#{invoice.id}\"]")
        expect(page).to have_css('.interactive-tag[data-field="status"]')
        expect(page).to have_css('.interactive-tag[data-value="active"]')
      end

      it 'select is hidden' do
        expect(page).to have_css('.interactive-tag-select')
        expect(page).to have_css('.select-container-hidden')
      end

      it 'shows select with required data' do
        expect(page).to have_css(".invoice-status-#{invoice.id}-select")
        expect(page).to have_css('.interactive-tag-select[data-model="invoice"]')
        expect(page).to have_css(".interactive-tag-select[data-object_id=\"#{invoice.id}\"]")
        expect(page).to have_css('.interactive-tag-select[data-field="status"]')
        expect(page).to have_css('.interactive-tag-select[data-value="active"]')
      end
    end

    context 'with no translations' do
      around do |example|
        I18n.with_locale('de') do
          example.run
        end
      end

      context "without interactive option" do
        before do
          register_index(Invoice) do
            tag_column :status
          end

          create_invoice(status: :archived)
          visit admin_invoices_path
        end

        it "shows untranslated text as value" do
          expect(page.find('td.col-status').text).to eq('Archived')
        end
      end

      context 'with interactive option' do
        include_examples 'interactive select rendering'

        it 'renders an option for each enum value, with translated text' do
          option_selector = '.interactive-tag-select option'
          expect(page.find("#{option_selector}[value='active']").text).to eq('active')
          expect(page.find("#{option_selector}[value='archived']").text).to eq('archived')
        end
      end
    end

    context 'with translations' do
      around do |example|
        I18n.with_locale('en') do
          example.run
        end
      end

      context "without interactive option" do
        before do
          register_index(Invoice) do
            tag_column :status
          end
        end

        context 'with value' do
          before do
            create_invoice(status: :archived)
            visit admin_invoices_path
          end

          it "shows translated text as value" do
            expect(page.find('td.col-status').text).to eq('Archivado')
          end
        end

        context 'without value' do
          before do
            create_invoice(status: nil)
            visit admin_invoices_path
          end

          it "shows text for nil value" do
            expect(page.find('td.col-status').text).to eq('No')
          end
        end
      end

      context 'with interactive option' do
        include_examples 'interactive select rendering'

        it 'renders an option for each enum value, with translated text' do
          option_selector = '.interactive-tag-select option'
          expect(page.find("#{option_selector}[value='active']").text).to eq('Activo')
          expect(page.find("#{option_selector}[value='archived']").text).to eq('Archivado')
        end
      end
    end
  end
end
