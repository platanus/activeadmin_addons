require "rails_helper"

describe ActiveAdminAddons::SelectHelpers do
  let!(:dummy_class) do
    Class.new do
      include ActiveAdminAddons::SelectHelpers

      attr_reader :method

      def initialize(object, method, options)
        @object = object
        @method = method
        @options = options
      end
    end
  end

  let(:object) do
    create_categories
    create_items
    create_invoice(items: Item.all, number: 1, category: @category1)
  end

  let(:options) do
    {
      collection: []
    }
  end

  let(:method) { :item_ids }
  let(:instance) { dummy_class.new(object, method, options) }

  def self.check_invalid_options(method_name)
    context "with nil object" do
      let(:options) { nil }

      it "raises error" do
        error = "missing @options hash"
        expect { instance.send(method_name) }.to raise_error(error)
      end
    end
  end

  describe "#initial_collection_to_select_options" do
    it { expect(instance.initial_collection_to_select_options).to eq([[nil], ["Item #1", 1]]) }
    check_invalid_options(:initial_collection_to_select_options)

    context "with no selected item" do
      before { object.item_ids = nil }

      it { expect(instance.initial_collection_to_select_options).to eq([[nil]]) }
    end
  end

  describe "#array_to_select_options" do
    let(:object) { create_invoice(number: "1,2") }
    let(:method) { :number }

    check_invalid_options(:array_to_select_options)

    it "returns selected items only" do
      result = [
        { id: "1", text: "1", selected: "selected" },
        { id: "2", text: "2", selected: "selected" }
      ]

      expect(instance.array_to_select_options).to eq(result)
    end

    context 'with array input value' do
      let(:object) do
        ObjectStruct = Struct.new(:array_of_integers)
        ObjectStruct.new([1, 2])
      end
      let(:method) { :array_of_integers }

      it "returns selected items only" do
        result = [
          { id: 1, text: 1, selected: "selected" },
          { id: 2, text: 2, selected: "selected" }
        ]

        expect(instance.array_to_select_options).to eq(result)
      end
    end

    context "with collection only" do
      let(:object) { create_invoice(number: nil) }

      let(:options) do
        {
          collection: [2, 3]
        }
      end

      it "returns collection items only" do
        result = [
          { id: "2", text: "2" },
          { id: "3", text: "3" }
        ]

        expect(instance.array_to_select_options).to eq(result)
      end
    end

    context "with selected items and collection" do
      let(:options) do
        {
          collection: [2, 3]
        }
      end

      it "returns collection + selected items" do
        result = [
          { id: "1", text: "1", selected: "selected" },
          { id: "2", text: "2", selected: "selected" },
          { id: "3", text: "3" }
        ]

        expect(instance.array_to_select_options).to eq(result)
      end
    end

    context "without selected items or collection" do
      let(:object) { create_invoice(number: nil) }

      it "returns empty array" do
        expect(instance.array_to_select_options).to eq([])
      end
    end
  end

  describe "#collection_to_select_options" do
    check_invalid_options(:collection_to_select_options)

    it "returns selected items only" do
      result = instance.collection_to_select_options

      expected_result = [
        { id: @item1.id, text: @item1.name, selected: "selected" },
        { id: @item2.id, text: @item2.name, selected: "selected" },
        { id: @item3.id, text: @item3.name, selected: "selected" }
      ]

      expect(result).to eq(expected_result)
    end

    it "edits options using a block" do
      result = instance.collection_to_select_options do |item, option|
        option[:extra] = item.class.to_s
      end

      expected_result = [
        { id: @item1.id, text: @item1.name, extra: "Item", selected: "selected" },
        { id: @item2.id, text: @item2.name, extra: "Item", selected: "selected" },
        { id: @item3.id, text: @item3.name, extra: "Item", selected: "selected" }
      ]

      expect(result).to eq(expected_result)
    end

    context "with collection only" do
      let(:object) do
        create_items
        create_invoice
      end

      let(:options) do
        {
          collection: Item.all
        }
      end

      it "returns collection items only" do
        result = instance.collection_to_select_options

        expected_result = [
          { id: @item1.id, text: @item1.name },
          { id: @item2.id, text: @item2.name },
          { id: @item3.id, text: @item3.name }
        ]

        expect(result).to eq(expected_result)
      end
    end

    context "with selected items and collection" do
      let(:object) do
        create_items
        create_invoice(items: [@item2])
      end

      let(:options) do
        {
          collection: Item.all
        }
      end

      it "returns collection + selected items" do
        result = instance.collection_to_select_options

        expected_result = [
          { id: @item1.id, text: @item1.name },
          { id: @item2.id, text: @item2.name, selected: "selected" },
          { id: @item3.id, text: @item3.name }
        ]

        expect(result).to eq(expected_result)
      end

      it "loads data-selected attribute" do
        instance.collection_to_select_options
        selected_option = { id: @item2.id, text: @item2.name }
        expect(instance.control_attributes[:data][:selected]).to eq(selected_option.to_json)
      end
    end

    context "without selected items or collection" do
      let(:object) { create_invoice }

      it "returns empty array" do
        expect(instance.collection_to_select_options).to eq([])
      end
    end
  end

  describe "#active_record_select?" do
    let(:options) do
      {
        collection: Item.all
      }
    end

    it { expect(instance.active_record_select?).to eq(true) }

    context "when collection is not an Active Record collection" do
      let(:options) do
        {
          collection: []
        }
      end

      it { expect(instance.active_record_select?).to eq(false) }
    end

    context "when no selected items" do
      let(:object) { create_invoice }

      it { expect(object.items.any?).to eq(false) }
      it { expect(instance.active_record_select?).to eq(true) }
    end

    context "when method does not represent an Active Record collection but collection is" do
      let(:method) { :number }

      it { expect(instance.active_record_select?).to eq(true) }
    end
  end

  describe "#selected_collection" do
    it { expect(instance.selected_collection).to eq(@invoice.items) }
  end

  describe "#selected_item" do
    it { expect(instance.selected_item).to eq(Item.first) }

    context "with belongs to association method" do
      let(:method) { :category_id }

      it { expect(instance.selected_item).to eq(Category.first) }
    end

    context "with no association method" do
      let(:method) { :number }

      it { expect(instance.selected_item).to eq("1") }
    end
  end
end
