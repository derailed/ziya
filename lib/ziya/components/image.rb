# -----------------------------------------------------------------------------
# Draw an image on a chart. Can also be used to reference another chart and 
# embed it in the current chart. (See XML/SWF docs for composite charts )
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Components
  # Renders the specified image (jpg/gif) on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.          
  class Image < Base  
    has_attribute :layer, :transition, :delay, :duration, :url, :x, :y, :width,
                  :height, :rotation, :alpha, :bevel, :glow, :blur, :timeout, :retry
  end
end