# -----------------------------------------------------------------------------
# Draws a rectangle for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Rect < Base  
    has_attribute :x, :y, :width, :height, :rotation,
                  :fill_color, :fill_alpha, :line_color, :line_alpha,
                  :line_thickness              
  end
end