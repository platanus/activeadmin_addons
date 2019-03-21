class ActiveAdmin::Views::Pages::Base
  alias_method :original_build, :build

  def build(*args)
    original_build(args)
    body.set_attribute "data-default-select", ActiveadminAddons.default_select
    body.set_attribute "data-select-config", ActiveadminAddons.select_config.to_json
  end
end
