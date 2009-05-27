require 'ziya/maps/support/base'
require 'color'

module Ziya::Maps::Support
  class HeatRange < Base    
    has_attribute   :base_color, :min, :max, :step, :color_step, :color_method
    
    def flatten( xml )
      ranges = compute_ranges
      ranges.each_pair do |range, color|
        xml.state( :id => 'range' ) do
          xml.data( range )
          xml.color( color )
        end      
      end
    end
    
    # -------------------------------------------------------------------------
    private
    
      # Compute heat color ranges
      def compute_ranges
        ranges  = {}
        color   = Color::RGB.from_html( base_color )
        current = min
    
        while current < max do
          ranges["#{current} - #{current+step-1}" ] = color.html.gsub( /#/, '' )
          color    = color.send( color_method || :darken_by, color_step )
          current += step
        end    
        ranges
      end    
  end
end