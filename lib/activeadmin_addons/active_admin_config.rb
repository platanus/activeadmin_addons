class ActiveAdmin::Views::Pages::Base
  alias_method :original_build, :build

  def build(*args)
    original_build(args)
    body.set_attribute "data-default-select", ActiveadminAddons.default_select
  end
end
