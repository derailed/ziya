# -----------------------------------------------------------------------------
# Create a blur filter
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the blur filter to be applied to some component ie chart_rect, axis_value, etc...
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=filter
  # for additional documentation, examples and futher detail.
  class Blur < Base  
    has_attribute :id, :blurX, :blurY, :quality
  end
end