# -----------------------------------------------------------------------------
# Meter gauge 
#
# Records current value from 0..10 and variance of changes of value between
# ticks.
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Gauges
  class Signal < Radial
  
    # -------------------------------------------------------------------------
    # ctor
    def initialize( license, design_id="signal" )
      super( license, design_id )
      options[:delta] = options[:signal] - options[:previous]      
    end

    # -------------------------------------------------------------------------
    # set signal prefs  
    def set_preferences( opts={} )
      super( opts )
      options[:delta] = options[:signal] - options[:previous]
    end
  
    # =========================================================================
    protected
        
      # -----------------------------------------------------------------------
      # setup signal gauge default options
      def default_options
        { 
          :x            => 20,
          :y            => 20,
          :signal       => 5,
          :previous     => 0,
          :average      => nil,
          :gauge_colors => %w[17ff00 49ff00 7cff00 aeff00 e1ff00 ffea00 ffb700 ff8300 ff5000 ff1c00 ff0000]
        }
      end

    # =========================================================================
    private    
    
      # draws signal polygons
      def signal_indicator( x, y, radius, width, length, start_angle, end_angle, tick_count, thickness, color )
        buff  = []
        rank  = options[:signal]
        avg   = options[:average]
        i     = start_angle    
        j     = start_angle + width
        count = 1
        while( i < end_angle ) do      
          fill_alpha = (rank < count) ? 40 : 100
          fill_color = colorizer( rank )      
          if ( avg and avg == count )
            fill_color = "0CFF00"
            fill_alpha = 70
          end
          x1, y1 = x+Math::sin(deg2rad(i))*(radius)       , y-Math::cos(deg2rad(i))*(radius)
          x2, y2 = x+Math::sin(deg2rad(i))*(radius+length), y-Math::cos(deg2rad(i))*(radius+length)
          x3, y3 = x+Math::sin(deg2rad(j))*(radius+length), y-Math::cos(deg2rad(j))*(radius+length)           
          x4, y4 = x+Math::sin(deg2rad(j))*(radius)       , y-Math::cos(deg2rad(j))*(radius)
      
          polygon = Ziya::Gauges::Support::Polygon.new( 
            :fill_color => fill_color, :fill_alpha => fill_alpha,
            :line_color => fill_color, :line_alpha => fill_alpha,
            :components => YAML::Omap[
              "rpt_#{count}_1".to_sym, Ziya::Gauges::Support::Point.new( :x => x1, :y => y1 ),
              "rpt_#{count}_2".to_sym, Ziya::Gauges::Support::Point.new( :x => x2, :y => y2 ),
              "rpt_#{count}_3".to_sym, Ziya::Gauges::Support::Point.new( :x => x3, :y => y3 ),
              "rpt_#{count}_4".to_sym, Ziya::Gauges::Support::Point.new( :x => x4, :y => y4 )
            ]
          )
          # dump polygon to yaml rep
          buff << "#{indent}#{polygon.to_comp_yaml( "r_poly_#{count}", 2 )}"              
          i += (end_angle-start_angle)/(tick_count)
          j = i + width
          count += 1
        end
        buff.join( "\n" )
    	end

      # -----------------------------------------------------------------------
      # draws signal change indicator
      def delta_indicator( x, y )
        buff        = []
        fill_color  = 'ff0000'
        fill_alpha  = 50
        spacer      = 10.0
        height      = 7.0
        start       = y
        fill_alphas = calc_change_alpha( options[:delta] )
        6.times do |i|
          fill_color = ( i < 3 ) ? 'ff0000' : '00ff00'
          fill_alpha = fill_alphas[i]
                        
          x1, y1 = x, start
          if i < 3
            x2, y2 = x+height/2, start-height
          else
            x2, y2 = x+height/2, start+height
          end
          x3, y3 = x+height, start
      
          polygon = Ziya::Gauges::Support::Polygon.new( 
            :fill_color => fill_color, :fill_alpha => fill_alpha,
            :line_color => fill_color, :line_alpha => fill_alpha,
            :components => YAML::Omap[
              "mpt_#{i}_1".to_sym, Ziya::Gauges::Support::Point.new( :x => x1, :y => y1 ),
              "mpt_#{i}_2".to_sym, Ziya::Gauges::Support::Point.new( :x => x2, :y => y2 ),
              "mpt_#{i}_3".to_sym, Ziya::Gauges::Support::Point.new( :x => x3, :y => y3 )
            ]
          )       
          buff << "#{indent}#{polygon.to_comp_yaml( "m_poly_#{i}", 2 )}"    
          start += (i+1) == 3 ? 5 : spacer
        end
        buff.join( "\n" )
      end

      # calculates the change delta for this one to previous
      def calc_change_alpha( change )
        alphas = []
        indexes = case change.abs
          when 0..1   : change >= 0 ? [2] : [3]
          when 1..5   : change >= 0 ? [1, 2] : [3,4]
          when 5...10 : change >= 0 ? [0, 1, 2] : [3,4,5]
        end
        6.times { |i| alphas[i] = indexes.include?(i) ? 100 : 10 }
        alphas
      end

      # colororize color wheel
      def colorizer( rank )
        options[:gauge_colors][rank]
      end
  end
end