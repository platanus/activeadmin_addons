require 'rails_helper'

describe "Date Time Picker Filter Input", type: :feature do
  let(:now) { DateTime.new(1984, 6, 4, 9, 0, 0).in_time_zone }

  before do
    register_page(Invoice) do
      config.sort_order = 'created_at_asc'

      filter :created_at, as: :date_time_picker_filter

      index do
        column :created_at
      end
    end

    5.times { |i| Invoice.create(id: i + 1, created_at: now + i.hours) }
    visit admin_invoices_path
  end

  it "shows date time pickers", js: true do
    expect(page).to have_css(".date-time-picker-input", count: 2)
    expect(page).to have_css("#q_created_at_gteq", count: 1)
    expect(page).to have_css("#q_created_at_lteq", count: 1)
  end

  context "setting min and max values" do
    before do
      find("#q_created_at_gteq").set("1984-06-04 10:00")
      find("#q_created_at_lteq").set("1984-06-04 12:00")
      click_filter_btn
    end

    it "shows filtered rows", js: true do
      expect(page).not_to have_css("#invoice_5")
      expect(page).to have_css("#invoice_4", count: 1)
      expect(page).to have_css("#invoice_3", count: 1)
      expect(page).to have_css("#invoice_2", count: 1)
      expect(page).not_to have_css("#invoice_1")
    end
  end

  context "setting min value only" do
    before do
      find("#q_created_at_gteq").set("1984-06-04 12:00")
      click_filter_btn
    end

    it "shows filtered rows", js: true do
      expect(page).to have_css("#invoice_5", count: 1)
      expect(page).to have_css("#invoice_4", count: 1)
      expect(page).not_to have_css("#invoice_3")
      expect(page).not_to have_css("#invoice_2")
      expect(page).not_to have_css("#invoice_1")
    end
  end

  context "setting max value only" do
    before do
      find("#q_created_at_lteq").set("1984-06-04 12:00")
      click_filter_btn
    end

    it "shows filtered rows", js: true do
      expect(page).not_to have_css("#invoice_5")
      expect(page).to have_css("#invoice_4", count: 1)
      expect(page).to have_css("#invoice_3", count: 1)
      expect(page).to have_css("#invoice_2", count: 1)
      expect(page).to have_css("#invoice_1", count: 1)
    end
  end
end
