require "rails_helper"

describe ActiveAdminAddons::InputOptionsHandler do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::InputOptionsHandler

      def initialize
        @options = {
          name: "Leandro",
          last_name: proc { "Segovia" }
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
      it { expect(instance.load_data_attr(:attr, default: 2)).to eq(2) }
    end

    context "passing value" do
      it { expect(instance.load_data_attr(:attr, value: 3, default: 2)).to eq(3) }
    end

    context "when value exits in @options" do
      it { expect(instance.load_data_attr(:name)).to eq("Leandro") }
      it { expect(instance.load_data_attr(:name, value: "Lean")).to eq("Lean") }
      it { expect(instance.load_data_attr(:name, default: "Danilo")).to eq("Leandro") }
    end

    context "when value is a Proc" do
      it { expect(instance.load_data_attr(:last_name)).to eq("Segovia") }
    end

    context "with custom formatter" do
      it { expect(instance.load_data_attr(:attr, value: 6, formatter: :to_s)).to eq("6") }
    end
  end

  describe "#load_class" do
    it "loads classes separated by spaces" do
      expect(instance.load_class("class-a")).to eq("class-a")
      expect(instance.load_class("class-b")).to eq("class-a class-b")
      expect(instance.load_class("    class-c    ")).to eq("class-a class-b class-c")
      expect(instance.load_class(nil)).to eq("class-a class-b class-c")
    end
  end

  describe "#control_attributes" do
    before do
      instance.load_data_attr(:attr, default: 6)
      instance.load_data_attr(:fields, value: ["a"], formatter: :to_json)
      instance.load_data_attr(:name)
      instance.load_class("class-a")
      instance.load_class("class-b")

      @attributes = {
        "data-attr" => 6,
        "data-fields" => "[\"a\"]",
        "data-name" => "Leandro",
        :class => "class-a class-b"
      }
    end

    it { expect(instance.control_attributes).to eq(@attributes) }
  end
end
