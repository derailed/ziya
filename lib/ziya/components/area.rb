# -----------------------------------------------------------------------------
# Defines an area on a chart. Typically used to embed links and buttons
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/components/base'

module Ziya::Components
  # Creates a linkable area on the chart to use with the link component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=link
  # for additional documentation, examples and futher detail.
  class Area < Base  
    has_attribute :x, :y, :width, :height, :url, :priority, :target, :text,
                  :font, :bold, :size, :color, :background_color, :alpha,
                  :timeout, :retry, :spinning_wheel           
  end
end