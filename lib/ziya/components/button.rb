# -----------------------------------------------------------------------------
# Draws a button on a chart
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Button component to draw a a button on the chart. 
  # Must be set up within the draw component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.            
  class Button < Base  
    has_attribute :layer, :transition, :delay, :duration,
                  :url_idle, :url_over, :url_press, :x, :y,
                  :width, :height, :alpha, 
                  :bevel, :glow, :blur, :shadow,
                  :timeout, :retry
  end
end