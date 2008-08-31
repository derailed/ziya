# -----------------------------------------------------------------------------
# Draws a point for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Point < Base  
    has_attribute :x, :y
  end
end