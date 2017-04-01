module ActiveadminAddons
  extend self

  attr_writer :default_select

  def default_select
    return "select2" unless @default_select
    @default_select
  end

  def setup
    yield self
    require "activeadmin_addons"
  end
end

require_relative './activeadmin_addons/engine'
