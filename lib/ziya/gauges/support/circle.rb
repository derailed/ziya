# -----------------------------------------------------------------------------
# Draws a circle for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Circle < Base  
    has_attribute :x, :y, :radius, :start, :end,
                  :fill_color, :fill_alpha, :line_color, :line_alpha,
                  :line_thickness              
  end
end