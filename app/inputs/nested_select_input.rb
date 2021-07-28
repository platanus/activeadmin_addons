class NestedSelectInput < ActiveAdminAddons::InputBase
  def to_html
    for_each_level { |attribute, data| concat(builder.input(attribute, level_options(data))) }
    parts_to_html
  end

  private

  def for_each_level
    hierarchy.each do |level_data|
      yield(level_data.delete(:attribute), level_data)
    end
  end

  def hierarchy
    data = get_levels_data
    raise("Undefined levels on nested_select") if data.empty?

    set_parent_attributes(data)
    data.reverse
  end

  def get_levels_data
    levels_data = []
    levels = @options.keys.select { |key| key.to_s.match(/level_[1-9]$/) }.reverse

    levels.each_with_index do |level_key, idx|
      previous_level_key = levels[idx + 1]
      validate_level_data!(level_key, previous_level_key)
      levels_data << @options.delete(level_key)
    end

    levels_data
  end

  def validate_level_data!(level_key, previous_level_key)
    current_level_number = get_level_number(level_key)
    previous_level_number = get_level_number(previous_level_key)

    if current_level_number != (previous_level_number + 1)
      raise("Missing :level_#{current_level_number - 1} key")
    end

    attribute = @options[level_key][:attribute]
    raise("Missing mandatory attribute level_key on #{level_key}") unless attribute
  end

  def get_level_number(level_key)
    level_key.to_s.split("_").last.to_i
  end

  def level_options(data)
    @options.merge(data).merge(as: :nested_level)
  end

  def set_parent_attributes(hierarchy)
    hierarchy.each_with_index do |level_data, idx|
      next_idx = idx + 1
      parent_level_data = hierarchy[next_idx] if hierarchy.count != next_idx
      if parent_level_data
        level_data[:parent_attribute] = parent_level_data[:attribute]
        set_parent_value(level_data)
      end
    end
  end

  def set_parent_value(level_data)
    parent_attribute = level_data[:parent_attribute]
    build_virtual_attr(parent_attribute)
    instance = instance_from_attribute_name(level_data[:attribute])
    if instance&.respond_to?(parent_attribute)
      @object.send("#{parent_attribute}=", instance.send(parent_attribute))
    end
  end

  def instance_from_attribute_name(attribute)
    return unless attribute

    attribute_value = @object.send(attribute)
    return unless attribute_value

    klass = class_from_attribute(attribute)
    klass.find_by(id: attribute_value)
  end

  def class_from_attribute(attribute)
    association_name = attribute.to_s.chomp("_id")
    association_name.camelize.constantize
  rescue NameError
    object_class.reflect_on_association(association_name).klass
  end

  def build_virtual_attr(attribute_name)
    if !@object.respond_to?(attribute_name) && !@object.respond_to?("#{attribute_name}=")
      @object.singleton_class.send(:attr_accessor, attribute_name)
    end
  end
end
