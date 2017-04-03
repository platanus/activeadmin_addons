class ActiveAdmin::Views::Pages::Base
  alias_method :original_add_classes_to_body, :add_classes_to_body

  def add_classes_to_body
    original_add_classes_to_body
    @body.set_attribute "data-default-select", ActiveadminAddons.default_select
  end
end
