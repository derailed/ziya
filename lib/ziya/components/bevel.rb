# -----------------------------------------------------------------------------
# Create a bevel filter
#
# Author:: Fernand
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the bevel filter to be applied to some component ie chart_rect, axis_value, etc...
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=filter
  # for additional documentation, examples and futher detail.    
  class Bevel < Base  
    has_attribute :id, :distance, :angle, :highlightColor, :highlightAlpha, 
                  :shadowColor, :shadowAlpha, :blurX, :blurY, :strength, 
                  :quality, :type, :knockout
  end
end