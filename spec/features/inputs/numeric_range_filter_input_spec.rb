require 'rails_helper'

describe "Numeric Range Filter Input", type: :feature do
  before do
    register_page(Invoice) do
      filter :position, as: :numeric_range_filter

      index do
        column :position
      end
    end

    5.times { |i| Invoice.create(position: i + 1) }
    visit admin_invoices_path
  end

  context "setting min value only" do
    before do
      input = find("#q_position_gteq")
      input.set(3)
      input.native.send_keys(:return)
    end

    it "shows filtered rows", js: true do
      expect(page).to have_css("#invoice_5", count: 1)
      expect(page).to have_css("#invoice_4", count: 1)
      expect(page).to have_css("#invoice_3", count: 1)
      expect(page).not_to have_css("#invoice_2")
      expect(page).not_to have_css("#invoice_1")
    end
  end

  context "setting max value only" do
    before do
      input = find("#q_position_lteq")
      input.set(3)
      input.native.send_keys(:return)
    end

    it "shows filtered rows", js: true do
      expect(page).not_to have_css("#invoice_5", count: 1)
      expect(page).not_to have_css("#invoice_4", count: 1)
      expect(page).to have_css("#invoice_3", count: 1)
      expect(page).to have_css("#invoice_2")
      expect(page).to have_css("#invoice_1")
    end
  end

  context "setting min and max values" do
    before do
      input = find("#q_position_gteq")
      input.set(2)
      input = find("#q_position_lteq")
      input.set(4)
      input.native.send_keys(:return)
    end

    it "shows filtered rows", js: true do
      expect(page).not_to have_css("#invoice_5", count: 1)
      expect(page).to have_css("#invoice_4", count: 1)
      expect(page).to have_css("#invoice_3", count: 1)
      expect(page).to have_css("#invoice_2")
      expect(page).not_to have_css("#invoice_1")
    end
  end
end
