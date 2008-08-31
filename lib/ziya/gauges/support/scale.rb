# -----------------------------------------------------------------------------
# Create an animation to scale a component
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Scale < Base  
    has_attribute :x, :y, :start_scale, :end_scale, :step, :direction,
                  :shake_span, :shake_frequency, :shake_snap,
                  :shadow_alpha, :shadow_x_offset, :shadow_y_offset, 
                  :components                  
  end  
end