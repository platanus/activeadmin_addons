require "rails_helper"

describe ActiveAdminAddons::InputHtmlHelpers do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::InputHtmlHelpers

      attr_reader :method

      def initialize(object, method)
        @object = object
        @method = method
      end
    end
  end

  let(:object) do
    create_categories
    create_invoice(category: @category1)
  end

  let(:method) { :category_id }
  let(:instance) { dummy_class.new(object, method) }

  describe "#prefixed_method" do
    it { expect(instance.prefixed_method).to eq("invoice_category_id") }
  end

  describe "#method_to_input_name" do
    it { expect(instance.method_to_input_name).to eq("invoice[category_id]") }
  end

  describe "#method_to_input_id" do
    let(:input_id) { 1 }

    it { expect(instance.method_to_input_id(input_id)).to eq("invoice_category_id_1") }

    context "with blank id" do
      let(:input_id) { nil }

      it { expect { instance.method_to_input_id(input_id) }.to raise_error("invalid input id") }
    end
  end

  describe "#selected_values_id" do
    it { expect(instance.selected_values_id).to eq("invoice_category_id_selected_values") }
  end

  describe "#empty_input_id" do
    it { expect(instance.empty_input_id).to eq("invoice_category_id_empty") }
  end
end
