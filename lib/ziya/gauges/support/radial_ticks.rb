# -----------------------------------------------------------------------------
# Draws a circle with ticks
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/radial_base'

module Ziya::Gauges::Support
  class RadialTicks < RadialBase  
    has_attribute :length, :thickness

    # overrides flatten to generate a series of radial tick marks
    def flatten( xml )
      i = start_angle   
      while( i <= end_angle ) do
        angle = deg2rad( i )
        hash = { :x1        => (x + Math::sin( angle ) * radius).to_i,
                 :y1        => (y - Math::cos( angle ) * radius).to_i,
                 :x2        => (x + Math::sin( angle ) * (radius + length)).to_i,
                 :y2        => (y - Math::cos( angle ) * (radius + length)).to_i,
                 :thickness => thickness,
                 :color     => color }
        xml.line( hash )
        i += (end_angle-start_angle)/(ticks-1)
      end
    end
    
  end
end