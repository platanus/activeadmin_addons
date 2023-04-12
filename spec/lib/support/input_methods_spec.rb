require "rails_helper"

describe ActiveAdminAddons::InputMethods do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::InputMethods

      attr_reader :method, :options

      def initialize(object, method, options = {})
        @object = object
        @method = method
        @options = options
      end
    end
  end

  let(:object) do
    create_categories
    create_items
    create_invoice(items: Item.all, category: @category1)
  end

  let(:method) { :category_id }
  let(:options) { {} }
  let(:instance) { dummy_class.new(object, method, options) }

  def self.check_invalid_method(method_name)
    context "with nil method" do
      let(:method) { nil }

      it "raises error" do
        error = "invalid method given"
        expect { instance.send(method_name) }.to raise_error(error)
      end
    end
  end

  def self.check_invalid_object(method_name)
    context "with nil object" do
      let(:object) { nil }

      it "raises error" do
        error = "blank object given"
        expect { instance.send(method_name) }.to raise_error(error)
      end
    end
  end

  describe "#model_name" do
    it { expect(instance.model_name).to eq("invoice") }

    check_invalid_object(:model_name)
  end

  describe "#method_model" do
    it { expect(instance.method_model).to be(Category) }

    check_invalid_method(:method_model)

    context "when class_name isn't defined and object is a namespaced class" do
      let(:object) { Store::Car.create name: "Fiesta", year: 2017 }
      let(:method) { :manufacturer_id }

      it "looks up the association with namespace" do
        expect(instance.method_model).to be(Store::Manufacturer)
      end
    end

    context "when a :method_model option is provided" do
      let(:options) { { method_model: Store::Car } }

      it "returns provided class" do
        expect(instance.method_model).to be(Store::Car)
      end
    end
  end

  describe "#tableize_method" do
    it { expect(instance.tableize_method).to eq("categories") }

    check_invalid_method(:tableize_method)
  end

  describe "#input_related_items" do
    it "raises error" do
      error = "no association called categories on invoice model"
      expect { instance.input_related_items }.to raise_error(error)
    end

    context "when method is a related collection" do
      let(:method) { :item_ids }

      it { expect(instance.input_related_items).to eq(@invoice.items) }
    end

    check_invalid_method(:input_related_items)
    check_invalid_object(:input_related_items)
  end

  describe "#input_value" do
    it { expect(instance.input_value).to eq(@invoice.category.id) }

    context "when method is a related collection" do
      let(:method) { :item_ids }

      it { expect(instance.input_value).to match_array(@invoice.items.ids) }
    end

    check_invalid_method(:input_value)
    check_invalid_object(:input_value)
  end

  describe "#input_association_value" do
    it { expect(instance.input_association_value).to eq(@invoice.category) }

    context "when method is a related collection" do
      let(:method) { :item_ids }

      it { expect { instance.input_association_value }.to raise_error(NoMethodError) }
    end

    check_invalid_method(:input_association_value)
    check_invalid_object(:input_association_value)
  end

  describe "#translated_method" do
    it { expect(instance.translated_method).to eq("Category") }

    check_invalid_method(:translated_method)
    check_invalid_object(:translated_method)
  end

  describe "#url_from_method" do
    it { expect(instance.url_from_method).to eq("/admin/categories") }

    context "when method is a related collection" do
      let(:method) { :item_ids }

      it { expect(instance.url_from_method).to eq("/admin/items") }
    end

    check_invalid_method(:url_from_method)
  end

  describe "#build_virtual_attr" do
    it { expect(object.respond_to?(:virtual_category_id_attr)).to eq(false) }
    it { expect(object.respond_to?(:virtual_category_id_attr=)).to eq(false) }

    context "defining accessor" do
      before { instance.build_virtual_attr }

      it { expect(object.respond_to?(:virtual_category_id_attr)).to eq(true) }
      it { expect(object.respond_to?(:virtual_category_id_attr=)).to eq(true) }

      it "raises error trying to define de attribute again" do
        expect { instance.build_virtual_attr }.to raise_error(
          "virtual_category_id_attr is already defined"
        )
      end
    end
  end
end
