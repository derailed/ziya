# -----------------------------------------------------------------------------
# Draws a rectangle for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Update < Base  
    has_attribute :url, :delay, :delay_type, :stop_sound, :retry, :timeout
  end
end