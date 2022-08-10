require 'rails_helper'

describe "Markdown Builder", type: :feature do
  context "shows text as markdown" do
    before do
      register_index(Invoice) do
        markdown_column :description
      end
    end

    context "with markdown text" do
      before do
        create_invoice(description: "# Header **bold** *italic*")
        visit admin_invoices_path
      end

      it "shows parsed markdown" do
        expect(page.html).to include("<h1>Header <strong>bold</strong> <em>italic</em></h1>")
      end
    end
  end

  context "shows text as markdown with custom options" do
    before do
      register_index(Invoice) do
        markdown_column :description, extensions: { highlight: true }
      end
    end

    context "with markdown text" do
      before do
        create_invoice(description: "This is ==highlighted==")
        visit admin_invoices_path
      end

      it "shows parsed markdown" do
        expect(page.html).to include("This is <mark>highlighted</mark>")
      end
    end
  end

  context "passing a block" do
    before do
      register_show(Invoice) do
        markdown_row(:description) do
          "# Header **bold** *italic*"
        end
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows parsed markdown" do
      expect(page.html).to include("<h1>Header <strong>bold</strong> <em>italic</em></h1>")
    end
  end

  context "passing a block with custom options" do
    before do
      register_show(Invoice) do
        markdown_row(:description, extensions: { highlight: true }) do
          "This is ==highlighted=="
        end
      end

      visit admin_invoice_path(create_invoice)
    end

    it "shows parsed markdown" do
      expect(page.html).to include("This is <mark>highlighted</mark>")
    end
  end
end
