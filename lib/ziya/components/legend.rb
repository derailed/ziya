# -----------------------------------------------------------------------------
# Sets up chart legend location
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Renders a legend on the chart
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=legend
  # for additional documentation, examples and futher detail.          
  
  class Legend < Base  
    has_attribute :transition, :delay, :duration,
      :x, :y, :width, :height, 
      :toggle, :layout, :margin, :bullet, :font, :bold, :size, :color, :alpha,
      :fill_color, :fill_alpha, :line_color, :line_alpha, :line_thickness,
      :shadow, :bevel, :glow, :blur
  end
end