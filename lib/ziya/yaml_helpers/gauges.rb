module Ziya::YamlHelpers::Gauges
  include Ziya::YamlHelpers::Base

  # generates a gauge yaml class declaration
  # ==== Example
  #  <%= gauge :thermo %>
  #
  #  produces:
  #
  #  --- !ruby/object:Ziya::Gauges::Thermo
  #    components: !omap
  def gauge( class_name )
    "--- #{clazz( class_name, 'Gauges' )}\n#{dials}" 
  end
  
  # generates a gauge element declaration
  # ==== Example
  #  <%= dial :rect %>
  #  => --- !ruby/object:Ziya::Gauges::Support::Rect
  def dial( comp_class, comp_name=nil )
    clazz = clazz( comp_class, "Gauges::Support" )
    comp_name ? "- :#{comp_name}: #{clazz}" : "- #{clazz}"
  end

  # generates a yaml hash of dials
  # ==== Example
  #  <%= dials %>
  #  => components: !omap
  def dials
    "components: !omap"
  end
  alias :components :dials
end