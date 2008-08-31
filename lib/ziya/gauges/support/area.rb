# -----------------------------------------------------------------------------
# Draws a clickable area for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Area < Base  
    has_attribute :x, :y, :width, :height, :url, :target, :text, :font, :bold, :size,
                  :color, :background_color, :alpha, :stop_sound
  end
end