require 'rails_helper'

describe "Dragonfly Attachment", type: :feature do
  after do
    Invoice.all.each do |invoice|
      invoice.dattachment = nil
      invoice.save!
    end
  end

  def create_attachment_invoice
    Invoice.create dattachment: File.new(
      ENGINE_RAILS_ROOT + 'spec/assets/entradas_para_dragon_ball_z.pdf')
  end

  context "without options" do
    before do
      register_show(Invoice) do
        dragonfly_attachment_row :dattachment, truncate: false
      end

      visit admin_invoice_path(create_attachment_invoice)
    end

    it "shows the attachment icon" do
      icon = page.find('img')
      expect(icon[:src]).to match(%r{/assets/fileicons/file_extension_pdf.png})
    end

    it "shows the attachment link" do
      expect(page).to have_link("entradas_para_dragon_ball_z.pdf")
    end
  end

  context "with custom link label" do
    before do
      register_index(Invoice) do
        dragonfly_attachment_column :dattachment, label: "Download"
      end

      create_attachment_invoice
      visit admin_invoices_path
    end

    it "shows the attachment link" do
      expect(page).to have_link("Download")
    end
  end

  context "with truncated link label" do
    before do
      register_index(Invoice) do
        dragonfly_attachment_column :dattachment, truncate: true
      end

      create_attachment_invoice
      visit admin_invoices_path
    end

    it "shows the attachment link" do
      expect(page).to have_link("entradas_para_dragon_ball_z...")
    end
  end

  context "without a block" do
    before do
      register_show(Invoice) do
        dragonfly_attachment_row(:dattachment, truncate: false) do
          invoice.dattachment
        end
      end

      visit admin_invoice_path(create_attachment_invoice)
    end

    it "shows the attachment as an image" do
      expect(page).to have_link("entradas_para_dragon_ball_z.pdf")
    end
  end

  context "using a label" do
    before do
      register_show(Invoice) do
        dragonfly_attachment_row("Mi documento", :dattachment)
      end

      visit admin_invoice_path(create_attachment_invoice)
    end

    it "shows custom label" do
      expect(page).to have_content("Mi Documento")
    end
  end
end
