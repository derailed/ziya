# -----------------------------------------------------------------------------
# Sets up a guide lines configuration for a chart
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies how to configure a guide for either axis on a chart
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=chart_guide
  # for additional documentation, examples and futher detail.        
  class ChartGuide < Base  
    has_attribute :horizontal, :vertical, :thickness, :color, :alpha, :type,
      :snap_h, :snap_v, :connect, 
      :radius, :fill_color, :line_color, :line_alpha, :line_thickness,
      :text_h_alpha, :text_v_alpha, :prefix_h, :prefix_v, :suffix_h, :suffix_v,
      :decimals, :decimal_char, :separator, :font, :bold, :size, :text_color,
      :background_color
  end
end