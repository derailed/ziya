# -----------------------------------------------------------------------------
# Draw a rectangle on a chart
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Rect component to draw a rectangle on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.            
  class Rect < Base  
    has_attribute :layer, :transition, :delay, :duration, :x, :y, :width,
                  :height, :fill_color, :fill_alpha, :line_color, :line_alpha,
                  :line_thickness,
                  :corner_tl, :corner_tr, :corner_bl, :corner_br,
                  :shadow, :bevel, :blur, :bevel
  end
end