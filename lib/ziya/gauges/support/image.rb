# -----------------------------------------------------------------------------
# Draws an image for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Image < Base  
    has_attribute :url, :x, :y, :width, :height, :rotation, :alpha, :retry, :timeout
  end
end