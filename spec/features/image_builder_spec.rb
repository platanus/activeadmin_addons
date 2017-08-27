require 'rails_helper'

describe "Image Builder", type: :feature do
  after do
    Invoice.all.each do |invoice|
      invoice.photo = nil
      invoice.save!
    end
  end

  def create_photo_invoice
    create_invoice(photo: File.new(ENGINE_RAILS_ROOT + 'spec/assets/Rails.png'))
  end

  context "without options" do
    before do
      register_index(Invoice) do
        image_column :photo
      end

      create_photo_invoice
      visit admin_invoices_path
    end

    it "shows the attachent as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end

  context "passing style option" do
    before do
      register_index(Invoice) do
        image_column :photo, style: :thumb
      end

      create_photo_invoice
      visit admin_invoices_path
    end

    it "shows the attachent as an image" do
      img = page.find('img')
      expect(img[:src]).to match(%r{thumb/Rails.png})
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        image_row(:photo, &:photo)
      end

      visit admin_invoice_path(create_photo_invoice)
    end

    it "shows the attachent as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        image_row("Mi foto", :photo)
      end

      visit admin_invoice_path(create_photo_invoice)
    end

    it "shows custom label" do
      expect(page).to have_content("Mi Foto")
    end
  end
end
