# -----------------------------------------------------------------------------
# Create a glow filter
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the glow filter to be applied to some component ie chart_rect, axis_value, etc...
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=filter
  # for additional documentation, examples and futher detail.      
  class Glow < Base  
    has_attribute :id, :color, :alpha, :blurX, :blurY, :strength, :quality, 
                  :inner, :knockout
  end
end