require "rails_helper"

describe ActiveAdminAddons::FilterInputMethods do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::FilterInputMethods

      attr_reader :method

      def initialize(object, method)
        @object = object
        @method = method
      end
    end
  end

  let(:value) { double(:value, value: 1) }
  let(:attribute_name) { method.to_s }
  let(:attribute) { double(:attribute, name: attribute_name) }
  let(:condition) { double(:condition, attributes: [attribute], values: [value]) }
  let(:object_klass) { Invoice }
  let(:object) { double(:ransack_search, conditions: [condition], klass: object_klass) }

  let(:method) { :category_id }
  let(:instance) { dummy_class.new(object, method) }

  describe "#input_value" do
    it { expect(instance.input_value).to eq(1) }

    context "when attribute does not match method" do
      let(:attribute_name) { "another_condition" }

      it { expect(instance.input_value).to be_nil }
    end
  end

  describe "#object_class" do
    it { expect(instance.object_class).to eq(object_klass) }
  end

  describe "#eq_input_name" do
    it { expect(instance.eq_input_name).to eq("category_id_eq") }
  end

  describe "#gteq_input_name" do
    it { expect(instance.gteq_input_name).to eq("category_id_gteq") }
  end

  describe "#lteq_input_name" do
    it { expect(instance.lteq_input_name).to eq("category_id_lteq") }
  end
end
