require 'rails_helper'

describe "Dragonfly Image", type: :feature do
  after do
    Invoice.all.each do |invoice|
      invoice.dphoto = nil
      invoice.save!
    end
  end

  def create_photo_invoice
    Invoice.create dphoto: File.new(ENGINE_RAILS_ROOT + 'spec/assets/Rails.png')
  end

  context "without options" do
    before do
      register_index(Invoice) do
        dragonfly_image_column :dphoto
      end

      create_photo_invoice
      visit admin_invoices_path
    end

    it "shows the attachment as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end

  context "passing size option" do
    before do
      register_index(Invoice) do
        dragonfly_image_column :dphoto, size: '100x100'
      end

      create_photo_invoice
      visit admin_invoices_path
    end

    it "shows the attachment as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        dragonfly_image_row(:dphoto, &:dphoto)
      end

      visit admin_invoice_path(create_photo_invoice)
    end

    it "shows the attachment as an image" do
      img = page.find('img')
      expect(img[:src]).to match(/Rails.png/)
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        dragonfly_image_row("Mi foto", :dphoto)
      end

      visit admin_invoice_path(create_photo_invoice)
    end

    it "shows custom label" do
      expect(page).to have_content("Mi Foto")
    end
  end
end
