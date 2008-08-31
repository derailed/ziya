# -----------------------------------------------------------------------------
# Draws a circle
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Circle component to draw a circle on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.          
  class Circle < Base  
    has_attribute :layer, :transition, :delay, :duration, :x, :y, :radius,
                  :fill_color, :fill_alpha, :line_color, :line_alpha,
                  :line_thickness, :shadow, :bevel, :glow, :blur
  end
end