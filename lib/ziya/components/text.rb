# -----------------------------------------------------------------------------
# Draws some text on a chart
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Components
  # Text component to draw text on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.            
  class Text < Base  
    has_attribute :layer, :transition, :delay, :duration, :x, :y, :width,
                  :height, :h_align, :v_align, :rotation, :font, :bold, :size,
                  :color, :alpha, :shadow, :bevel, :glow, :blur, :text
  end
end