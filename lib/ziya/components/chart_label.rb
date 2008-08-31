# -----------------------------------------------------------------------------
# Sets up chart labels configuration. These are the labels on top on the chart.
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the label for the chart element actual value. This can be setup to 
  # be fixed or as a tooltip
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=chart_label
  # for additional documentation, examples and futher detail.          
  class ChartLabel < Base  
    has_attribute :prefix, :suffix, :decimals, :decimal_char, :separator, :position,
                  :hide_zero, :as_percentage, :font, :bold, :size, :color,
                  :background_color, :alpha, :shadow, :bevel, :glow, :blur        
  end
end