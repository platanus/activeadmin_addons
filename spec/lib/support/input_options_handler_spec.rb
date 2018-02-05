require "rails_helper"

describe ActiveAdminAddons::InputOptionsHandler do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::InputOptionsHandler

      def initialize
        @options = {
          name: "Leandro",
          last_name: proc { "Segovia" },
          active: false
        }
      end

      def template
        Object.new
      end
    end
  end

  let(:instance) { dummy_class.new }

  describe "#load_data_attr" do
    context "with default value" do
      it { expect(instance.load_data_attr(:attr, default: 2)).to eq(value: 2) }
    end

    context "passing value" do
      it { expect(instance.load_data_attr(:attr, value: 3, default: 2)).to eq(value: 3) }
    end

    context "when value exits in @options" do
      it { expect(instance.load_data_attr(:name)).to eq(value: "Leandro") }
      it { expect(instance.load_data_attr(:name, value: "Lean")).to eq(value: "Lean") }
      it { expect(instance.load_data_attr(:name, default: "Danilo")).to eq(value: "Leandro") }
    end

    context "when value is a Proc" do
      it { expect(instance.load_data_attr(:last_name)).to eq(value: "Segovia") }
    end

    context "with custom formatter" do
      it "returns item with formatter" do
        item = instance.load_data_attr(:attr, value: 6, formatter: :to_s)
        expect(item).to eq(value: 6, formatter: :to_s)
      end
    end
  end

  describe "#get_data_attr_value" do
    it "returns loaded attribute" do
      instance.load_data_attr(:attr, value: 6, formatter: :to_s)
      expect(instance.get_data_attr_value(:attr)).to eq(6)
    end

    it { expect(instance.get_data_attr_value(:attr)).to be_nil }
  end

  describe "#load_class" do
    it "loads classes separated by spaces" do
      expect(instance.load_class("class-a")).to eq("class-a")
      expect(instance.load_class("    class-b    ")).to eq("class-b")
      expect(instance.load_class(nil)).to be_nil
    end
  end

  describe "#control_attributes" do
    before do
      instance.load_data_attr(:attr, default: 6)
      instance.load_data_attr(:fields, value: ["a"], formatter: :to_json)
      instance.load_data_attr(:name)
      instance.load_data_attr(:active, default: true)
      instance.load_class("class-a class-b")
      instance.load_class(nil)
      instance.load_class("  class-c    ")

      @attributes = {
        data: {
          attr: 6,
          fields: "[\"a\"]",
          name: "Leandro",
          active: false
        },
        class: "class-a class-b class-c"
      }
    end

    it { expect(instance.control_attributes).to eq(@attributes) }
  end
end
