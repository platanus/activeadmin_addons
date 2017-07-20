require 'rails_helper'

describe "Range DateTime Picker Filter", type: :feature do
  before do
    register_page(Invoice) do
      filter :updated_at, as: :range_date_time_picker      
    end

    5.times { |i| Invoice.create() }
    Invoice.all.each do |invoice|
      invoice.updated_at = invoice.updated_at + invoice.id.days
      invoice.save
    end    
    visit admin_invoices_path
  end

  context "filter has date-time-picker" do
    it "shows gt & lt datepickers", js: true do
      expect(page).to have_css(".date-time-picker", count: 2)
      expect(page).to have_css("#q_updated_at_gteq", count: 1)
      expect(page).to have_css("#q_updated_at_lteq", count: 1)
    end
  end

  context "setting min value only" do
    before do
      my_date = Invoice.find(3).updated_at.utc
      input = find("#q_updated_at_gteq")
      input.set(my_date.strftime("%Y-%m-%d %H:%M"))
      click_button("Filter")
    end

    it "shows filtered rows", js: true do
      expect(page).to have_css("#invoice_5")
      expect(page).to have_css("#invoice_4")
      expect(page).to have_css("#invoice_3")
      expect(page).to_not have_css("#invoice_2")
      expect(page).to_not have_css("#invoice_1")
    end
  end

  context "setting max value only" do
    before do
      my_date = Invoice.find(3).updated_at.utc
      input = find("#q_updated_at_lteq")
      input.set(my_date.strftime("%Y-%m-%d %H:%M"))
      click_button("Filter")
    end

    it "shows filtered rows", js: true do
      expect(page).to_not have_css("#invoice_5")
      expect(page).to_not have_css("#invoice_4")
      expect(page).to_not have_css("#invoice_3")
      expect(page).to have_css("#invoice_2")
      expect(page).to have_css("#invoice_1")
    end
  end

  context "setting min and max values" do
    before do
      min_date = Invoice.find(2).updated_at.utc
      max_date = Invoice.find(4).updated_at.utc
      input = find("#q_updated_at_gteq")
      input.set(min_date.strftime("%Y-%m-%d %H:%M"))
      input = find("#q_updated_at_lteq")
      input.set(max_date.strftime("%Y-%m-%d %H:%M"))
      click_button("Filter")
    end

    it "shows filtered rows", js: true do
      expect(page).to_not have_css("#invoice_5")
      expect(page).to_not have_css("#invoice_4")
      expect(page).to have_css("#invoice_3")
      expect(page).to have_css("#invoice_2")
      expect(page).to_not have_css("#invoice_1")
    end
  end
end
