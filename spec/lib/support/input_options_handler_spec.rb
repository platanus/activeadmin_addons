require "rails_helper"

describe ActiveAdminAddons::InputOptionsHandler do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::InputOptionsHandler

      def initialize
        @options = {
          name: "Leandro"
        }
      end
    end
  end

  let(:instance) { dummy_class.new }

  describe "#load_attr" do
    context "with default value" do
      it { expect(instance.load_attr(:unknown_attr)).to be_nil }
      it { expect(instance.load_attr(:fields)).to eq(["name"].to_json) }
      it { expect(instance.load_attr(:minimum_input_length)).to eq(1) }
    end

    context "overriding default value" do
      it { expect(instance.load_attr(:unknown_attr, default: 6)).to eq(6) }
      it { expect(instance.load_attr(:fields, default: ["a"])).to eq(["a"].to_json) }
      it { expect(instance.load_attr(:minimum_input_length, default: 2)).to eq(2) }
    end

    context "passing value" do
      it { expect(instance.load_attr(:unknown_attr, value: 555, default: 666)).to eq(555) }
      it { expect(instance.load_attr(:fields, value: ["a"], default: ["b"])).to eq(["a"].to_json) }
      it { expect(instance.load_attr(:minimum_input_length, value: 3)).to eq(3) }
    end

    context "when value exits in @options" do
      it { expect(instance.load_attr(:name)).to eq("Leandro") }
      it { expect(instance.load_attr(:name, value: "Lean")).to eq("Lean") }
      it { expect(instance.load_attr(:name, default: "Danilo")).to eq("Leandro") }
    end

    context "with custom formatter" do
      it { expect(instance.load_attr(:attr, value: 6, formatter: :to_s)).to eq("6") }
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
      instance.load_attr(:minimum_input_length)
      instance.load_attr(:unknown_attr, default: 6)
      instance.load_attr(:fields, value: ["a"])
      instance.load_attr(:name)
      instance.load_class("class-a")

      @attributes = {
        "data-minimum_input_length" => 1,
        "data-unknown_attr" => 6,
        "data-fields" => "[\"a\"]",
        "data-name" => "Leandro",
        :class => "class-a"
      }
    end

    it { expect(instance.control_attributes).to eq(@attributes) }
  end
end
