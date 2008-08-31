# -----------------------------------------------------------------------------
# Draws a set of numbers in a circular layout
#
# BOZO !! use components to render ??
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/radial_base'

module Ziya::Gauges::Support
  class RadialNumbers < RadialBase  
    has_attribute :start_num, :end_num, 
                  :font, :size, :bold, :width, :height, :align

    # overrides flatten to generate a series of radial tick marksß
    def flatten( xml )
      number = start_num
      i      = start_angle
      while( i <= end_angle ) do
        angle = deg2rad( i )
        hash = { :x         => (x + Math::sin( angle ) * radius).to_i,
                 :y         => (y - Math::cos( angle ) * radius).to_i,
                 :width     => width ||  20,
                 :height    => height || 20,
                 :font      => font || "Arial",
                 :size      => size || 10,
                 :bold      => bold || true,
                 :alpha     => alpha,                 
                 :rotation  => i, 
                 :align     => align || "left",
                 :color     => color }
        xml.text( hash ) do
          xml.text! number.to_s
        end
        i      += (end_angle-start_angle)/(ticks-1)
        number += (end_num-start_num)/(ticks-1)
      end
    end      
        
  end
end  