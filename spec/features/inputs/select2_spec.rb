require "rails_helper"

describe "Select 2", type: :feature do
  it { expect(ActiveadminAddons.default_select).to eq('select2') }

  context "when default config is select 2" do
    before do
      ActiveadminAddons.default_select = 'select2'

      register_form(Invoice) do |f|
        f.input :category
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows select control as select 2", js: true do
      expect_select2_options_count_to_eq(3)
      expect(page).not_to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end

    context "with tags: true option" do
      let(:invoice) { create_invoice }
      let(:selection) { '#444' }

      context "with AA form" do
        before do
          register_form(Invoice) do |f|
            f.input :number, as: :select, collection: ["#111", "#222", "#333"], tags: true
          end
        end

        context 'when entering option not in collection' do
          before { visit edit_admin_invoice_path(invoice) }

          it "adds new option", js: true do
            expect_select2_options_count_to_eq(4)
            fill_select2_input(selection)
            expect_select2_options_count_to_eq(5)
          end
        end

        context 'when initial value is not in inputs collection' do
          before do
            invoice.update!(number: selection)
            visit edit_admin_invoice_path(invoice)
          end

          it "includes initial value as option", js: true do
            expect_select2_options_count_to_eq(5)
          end
        end
      end

      context "with custom form" do
        before do
          register_page(Invoice) do
            config.filters = false
            sidebar 'Filters' do
              active_admin_form_for(:q) do |f|
                f.input :number, as: :select, collection: ["#111", "#222", "#333"], tags: true
              end
            end
          end
        end

        context 'when entering option not in collection' do
          before { visit admin_invoices_path }

          it "adds new option", js: true do
            expect_select2_options_count_to_eq(4)
            fill_select2_input(selection)
            expect_select2_options_count_to_eq(5)
          end
        end
      end
    end

    context "with tags: false option" do
      let(:selection) { '#444' }

      before do
        register_form(Invoice) do |f|
          f.input :number, as: :select, collection: ["#111", "#222", "#333"], tags: false
        end
      end

      context 'when entering option not in collection' do
        let(:selection) { '#444' }

        before { visit edit_admin_invoice_path(create_invoice) }

        it "doesn't add new option", js: true do
          expect_select2_options_count_to_eq(4)
          fill_select2_input(selection)
          expect_select2_options_count_to_eq(4)
        end
      end
    end
  end

  context "when default config is select 2 and select control has default-select class" do
    before do
      register_form(Invoice) do |f|
        f.input :category, input_html: { class: "default-select" }
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows normal select control", js: true do
      expect_select2_options_count_to_eq(0)
      expect(page).to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end
  end

  context "when default config is Active Admin's default" do
    before do
      ActiveadminAddons.default_select = 'default'

      register_form(Invoice) do |f|
        f.input :category
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows normal select control", js: true do
      expect_select2_options_count_to_eq(0)
      expect(page).not_to have_selector("select.default-select")
      expect(page).not_to have_selector("select.select2")
    end
  end

  context "when default config is Active Admin's default and select control has select 2 class" do
    before do
      ActiveadminAddons.default_select = 'default'

      register_form(Invoice) do |f|
        f.input :category, input_html: { class: "select2" }
      end

      create_categories
      visit edit_admin_invoice_path(create_invoice(category: @category2))
    end

    it "shows select control as select 2", js: true do
      expect_select2_options_count_to_eq(3)
      expect(page).not_to have_selector("select.default-select")
      expect(page).to have_selector("select.select2")
    end
  end

  context "when building ActiveAdmin html" do
    describe "the <body> element" do
      it "is present in the document only once" do
        visit admin_invoices_path

        expect(page.all('body').size).to eq 1
      end

      it "contains the data-default-select attribute" do
        visit admin_invoices_path

        body = find("body")
        expect(body['data-default-select']).to eq ActiveadminAddons.default_select
      end
    end
  end
end
