# -----------------------------------------------------------------------------
# Create an animation to move a component
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Move < Base  
    has_attribute :start_x_offset, :start_y_offset, :end_x_offset, :end_y_offset, :step, 
                  :shake_span, :shake_frequency, :shake_snap,
                  :shadow_alpha, :shadow_x_offset, :shadow_y_offset, 
                  :components
  end  
end