# -----------------------------------------------------------------------------
# Draws things in a circular layout. This is an abstract class and should not
# be used directly.
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class RadialBase < Base  
    has_attribute :x, :y, :radius, :start_angle, :end_angle, :ticks, :color, :alpha
    
    # =========================================================================
    protected
    
      # converts degrees to radiant
      def deg2rad( degrees )
        degrees * Math::PI / 180
      end
  end
end  