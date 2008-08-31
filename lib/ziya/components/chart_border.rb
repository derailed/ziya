# -----------------------------------------------------------------------------
# Sets up chart border configuration
#
# Author:: Fernand
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies how to render a chart border
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=chart_border
  # for additional documentation, examples and futher detail.      
  class ChartBorder < Base  
    has_attribute :top_thickness, :bottom_thickness, :left_thickness,
                  :right_thickness, :color                      
  end
end