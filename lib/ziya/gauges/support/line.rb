# -----------------------------------------------------------------------------
# Draws a line for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Line < Base  
    has_attribute :x1, :y1, :x2, :y2, :color, :alpha, :thickness
  end
end