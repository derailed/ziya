# -----------------------------------------------------------------------------
# Thermometer gauge 
#
# TODO Need to figure out ordering different than alpha
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Gauges
  class Thermo < Base
  
    # creates a thermometer gauge.
    # <tt>license</tt> the xml/swf gauge license key
    # <tt>design_id</tt> the name of the design file containing components
    # to override default design.
    def initialize( license, design_id="thermo" )
      super( license, design_id )
    end

    # -----------------------------------------------------------------------
    # provides for overiding basic functionality
    #
    # <tt>title</tt>::         String representing gauge title or null for none.
    # <tt>gauge_color</tt>::   Legend color
    # <tt>legend_color</tt>::  Gauge color
    # <tt>due_point</tt>::     Set temperature level
    def set_preferences( opts={} )
      super( opts )
      options[:end_scale] = normalize_and_scale( options[:due_point] )
    end
  
    # =========================================================================
    protected
    
      # -------------------------------------------------------------------------
      # setup thermometer default options
      def default_options
        { 
          :x            => 20,
          :y            => 20,
          :due_point    => 40,
          :gauge_color  => "ff0000",
          :legend_color => "cc0000",
          :title        => "weather"
        }
      end

    # =========================================================================
    private
                
      # -----------------------------------------------------------------------
      # converts temp is F to a % 
      def normalize_and_scale( due_point )
        return 100 if due_point > 120
        return 0 if due_point < 20
        due_point - 20
      end
    
      # -----------------------------------------------------------------------
      # draws farenheit scale
      def draw_farenheit_scale( start_temp, end_temp )
        i     = start_temp
        buff  = []
        count = 0
        x = options[:x] + 60
        y = options[:y] + 153
        while( i <= end_temp ) do
      		line = Ziya::Gauges::Support::Line.new( 
      		  :x1        => x, 
      		  :y1        => y-i, 
      		  :x2        => x+8, 
      		  :y2        => y-i, 
      		  :thickness => 2 )
      		buff << "#{indent}#{line.to_comp_yaml( "linef_#{count}", 2 )}"
      		text = Ziya::Gauges::Support::Text.new( 
      		  :x     => x+8,  
      		  :y     => (y-8)-i,  
      		  :width => 100,  
      		  :align => 'left', 
      		  :size  => 10, 
      		  :color => 'aaaaaa', 
      		  :text  => i.to_s )
      		buff << "#{indent}#{text.to_comp_yaml( "textf_#{count}", 2 )}"
      		i     += 20
      		count += 1
      	end
      	buff.join( "\n" )
      end
  
      # -----------------------------------------------------------------------
      # draws celsius scale
      def draw_celsius_scale( start_temp, end_temp )
        i     = start_temp
        ratio = 1.7
        buff  = []
        count = 0
        x = options[:x] + 10
        y = options[:y] + 118        
        while( i <= end_temp ) do
      		line = Ziya::Gauges::Support::Line.new( 
      		  :x1        => x, 
      		  :y1        => y-(i*ratio), 
      		  :x2        => x+8, 
      		  :y2        => y-(i*ratio), 
      		  :thickness => 2 )
      		buff << "#{indent}#{line.to_comp_yaml( "linec_#{count}", 2 )}"
      		text = Ziya::Gauges::Support::Text.new( 
      		  :x     => x - 20,  
      		  :y     => (y-8)-(i*ratio),  
      		  :width => 20,  
      		  :align => 'right', 
      		  :size  => 10, 
      		  :color => 'aaaaaa', 
      		  :text  => i.to_s )
      		buff << "#{indent}#{text.to_comp_yaml( "text_c_#{count}", 2 )}"
      		i     += 10
      		count += 1
      	end
      	buff.join( "\n" )
      end    
  end
end