# -----------------------------------------------------------------------------
# Draws a polygon for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Polygon < Base  
    has_attribute :fill_color, :fill_alpha, :line_color, :line_alpha, 
                  :line_thickness, :components              
  end
end