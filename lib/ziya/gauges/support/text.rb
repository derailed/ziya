# -----------------------------------------------------------------------------
# Draws text for a gauge
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Text < Base  
    has_attribute :x, :y, :width, :height, :rotation, :font, :bold, :size, :align,
                  :color, :alpha, :text
                  
    def flatten( xml )
      opts = options
      txt = opts.delete( :text )
      xml.text( opts ) do
        xml.text! txt.to_s
      end
    end                  
  end
end