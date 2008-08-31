# -----------------------------------------------------------------------------
# Setup configuration on the chart value axis
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the label attribute on the x or y axis depending on the chart type.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=axis_value
  # for additional documentation, examples and futher detail.    
  class AxisValue < Base  
    has_attribute :min, :max, :steps, :prefix, :suffix, :decimals,
                  :decimal_char, :separator, :show_min, :font, :bold,
                  :size, :color, :background_color, :alpha, :orientation,
                  :shadow, :bevel, :glow, :blur
  end
end