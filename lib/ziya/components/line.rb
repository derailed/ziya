# -----------------------------------------------------------------------------
# Draw a line on a chart
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Line component to draw a line on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.            
  class Line < Base  
    has_attribute :layer, :transition, :delay, :duration, :x1, :y1, :x2, :y2,
                  :line_color,:line_alpha, :line_thickness, 
                  :bevel, :glow, :blur, :shadow
  end
end