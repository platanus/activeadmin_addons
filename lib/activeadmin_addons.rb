module ActiveadminAddons
  extend self

  attr_writer :default_select, :datetime_picker_default_options, :datetime_picker_input_format, :display_name_methods

  def default_select
    return "select2" unless @default_select
    @default_select
  end

  def datetime_picker_default_options
    return {} unless @datetime_picker_default_options
    @datetime_picker_default_options
  end

  def datetime_picker_input_format
    return "%Y-%m-%d %H:%M" unless @datetime_picker_input_format
    @datetime_picker_input_format
  end

  def display_name_methods
    @display_name_methods ||= ActiveAdmin.application.display_name_methods
  end

  def default_display_name(object)
    (display_name_methods - association_methods(object)).detect { |method| object.respond_to?(method) }
  end

  def association_methods(object)
    return [] unless object.class.respond_to?(:reflect_on_all_associations)
    object.class.reflect_on_all_associations.map(&:name)
  end

  def setup
    yield self
    require "activeadmin_addons"
  end
end

require_relative './activeadmin_addons/engine'
