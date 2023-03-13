require 'rails_helper'

describe "Image Builder", type: :feature do
  after do
    Invoice.all.each do |invoice|
      invoice.picture = nil
      invoice.save!
    end
  end

  def create_picture_invoice
    create_invoice(picture: File.new(ENGINE_RAILS_ROOT + 'spec/assets/Rails.png'))
  end

  describe '#shrine' do
    context "without options" do
      before do
        register_index(Invoice) do
          image_column :picture
        end

        create_picture_invoice
        visit admin_invoices_path
      end

      it "shows the attachent as an image" do
        img = page.find('img')
        expect(img[:src]).not_to be(nil)
      end
    end

    context "passing style option" do
      let(:invoice) { create_picture_invoice }

      before do
        register_index(Invoice) do
          image_column :picture, style: :jpg_small
        end

        invoice.picture_derivatives!
        invoice.save!
        visit admin_invoices_path
      end

      it "shows the attachent as an image" do
        img = page.find('img')
        expect(img[:src]).not_to be(nil)
      end

      it 'has the derivative' do
        expect(invoice.picture_derivatives).to include(:jpg_small)
      end
    end

    context "passing a block" do
      before do
        register_show(Invoice) do
          image_row(:picture, &:picture)
        end

        visit admin_invoice_path(create_picture_invoice)
      end

      it "shows the attachent as an image" do
        img = page.find('img')
        expect(img[:src]).not_to be(nil)
      end
    end

    context "using a label" do
      before do
        register_show(Invoice) do
          image_row("My Picture", :picture)
        end

        visit admin_invoice_path(create_picture_invoice)
      end

      it "shows custom label" do
        expect(page).to have_content("My Picture")
      end
    end
  end
end
