# -----------------------------------------------------------------------------
# Create an animation to rotate a component
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Rotate < Base  
    has_attribute :x, :y, :start, :step, :span, 
                  :shake_span, :shake_frequency, :shake_snap,
                  :shadow_alpha, :shadow_x_offset, :shadow_y_offset, 
                  :components
  end  
end