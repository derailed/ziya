# -----------------------------------------------------------------------------
# Sets the label attributes for the category-axis.
#
# Author:: Fernand
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the label attributes on the x or y axis depending on the chart type.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=axis_category
  # for additional documentation, examples and futher detail.  
  class AxisCategory < Base    
    has_attribute :skip, :font, :bold, :size, :color, :alpha, :orientation,
                  :margin, 
                  :min, :max, :steps, :mode, :prefix, :suffix, :decimals,
                  :decimal_char, :separator, 
                  :bevel, :glow, :shadow, :blur
  end
end