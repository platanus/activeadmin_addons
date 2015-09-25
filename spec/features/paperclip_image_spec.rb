require 'rails_helper'

describe "Paperclip Image", type: :feature do
  after do
    Invoice.all.each do |invoice|
      invoice.photo = nil
      invoice.save!
    end
  end

  context "Using image_column" do
    before do
      register_index(Invoice) do
        image_column :photo
      end

      @invoice = Invoice.create photo: File.new(ENGINE_RAILS_ROOT + 'spec/assets/Rails.png')
      visit admin_invoices_path
    end

    it "shows the attachent as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end
end
