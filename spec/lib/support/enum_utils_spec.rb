require "rails_helper"

describe ActiveAdminAddons::EnumUtils do
  let(:model_name) { 'SomeModel' }
  let(:model_class) { model_name.constantize }
  let(:enum_translations) { { value1: 'value 1 translation', value2: 'value 2 translation' } }
  let(:generic_model) do
    Class.new(ActiveRecord::Base) do # rubocop:disable Rails/ApplicationRecord
      enum some_enum: { value1: 0, value2: 1 }
    end
  end

  def translation_key(enum_option_to_translate)
    "activerecord.attributes.some_model.some_enums.#{enum_option_to_translate}"
  end

  before do
    stub_const(model_name, generic_model)
    enum_translations.each do |enum_option_name, enum_translation|
      allow(I18n).to receive(:t).with(
        translation_key(enum_option_name), default: enum_option_name.to_s
      ).and_return(enum_translation)
    end
  end

  describe '#options_for_select' do
    context 'using enum option name as value' do
      let(:expected_options) do
        enum_translations.map do |enum_option_name, enum_translation|
          [enum_translation, enum_option_name.to_s]
        end
      end

      it 'returns correct array of translations and enum option names' do
        options = described_class.options_for_select(model_class, 'some_enum')
        expect(options).to match_array(expected_options)
      end
    end

    context 'using db value' do
      let(:expected_options) do
        enum_translations.map do |enum_option_name, enum_translation|
          [enum_translation, generic_model.some_enums[enum_option_name]]
        end
      end

      it 'returns correct array of translations and enum db values' do
        options = described_class.options_for_select(model_class, 'some_enum', use_db_value: true)
        expect(options).to match_array(expected_options)
      end
    end
  end

  describe '#translate_enum_option' do
    context 'with enum option name present in enum' do
      let(:enum_option_to_translate) { 'value1' }

      it 'returns correct translation' do
        translation = described_class.translate_enum_option(
          model_class, 'some_enum', enum_option_to_translate
        )
        expect(translation).to eq(enum_translations[enum_option_to_translate.to_sym])
      end
    end

    context 'with enum option name not present in enum' do
      let(:enum_option_to_translate) { 'unknown_value' }

      before do
        allow(I18n).to receive(:t).with(
          translation_key(enum_option_to_translate), default: enum_option_to_translate.to_s
        ).and_return(enum_option_to_translate)
      end

      it 'returns untranslated enum option name' do
        translation = described_class.translate_enum_option(
          model_class, 'some_enum', enum_option_to_translate
        )
        expect(translation).to eq(enum_option_to_translate)
      end
    end

    context 'with blank enum option name' do
      let(:enum_option_to_translate) { nil }

      it 'returns nil' do
        translation = described_class.translate_enum_option(
          model_class, 'some_enum', enum_option_to_translate
        )
        expect(translation).to eq(nil)
      end
    end
  end
end
