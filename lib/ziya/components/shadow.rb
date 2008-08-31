# -----------------------------------------------------------------------------
# Create a shadow filter
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the shadow filter to be applied to some component ie chart_rect, axis_value, etc...
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=filter
  # for additional documentation, examples and futher detail.      
  class Shadow < Base  
    has_attribute :id, :distance, :angle, :color, :alpha, 
                  :blurX, :blurY, :strength, :quality, :inner, :knockout, :hideObject
  end
end