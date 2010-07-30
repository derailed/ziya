# -----------------------------------------------------------------------------
# == Ziya::Maps::Base
#
# Maps mother ship
#
# Author:: Fernand Galiana
# Date::   Jan 01 2009
# -----------------------------------------------------------------------------
require 'ziya/yaml_helpers/maps'
require 'ziya/html_helpers/maps'

module Ziya::Maps
  class Base
    include Ziya::YamlHelpers::Maps, Ziya::HtmlHelpers::Maps
    
    # =========================================================================                
    protected     
      def self.map_types
        @map_types ||= [ 
          :australia, 
          :belgium, 
          :brazil, 
          :canada, 
          :europe, 
          :france, 
          :germany, 
          :italy, 
          :mexico, 
          :sweden, 
          :uk_ireland, 
          :us, 
          :us_canada, 
          :world ]
      end 
      
      # defines the various map components
      def self.declare_components # :nodoc:
        @components = 
        [
          :arc, 
          :arc_color, 
          :arc_range, 
          :background_color, 
          :default_color, 
          :default_point, 
          :first_zoom,
          :hover, 
          :heat_range,
          :line,
          :line_color, 
          :line_range, 
          :outline_color, 
          :point,
          :point_range, 
          :ranges,
          :range,
          :region, 
          :scale_points,           
          :show_name,           
          :state, 
          :state_info_icon,
          :zoom_mode, 
          :zoom_out_button,
          :zoom_out_scale
        ]                              
        @components.each { |a| attr_accessor a }      
      end    
      declare_components
    

    # =========================================================================    
    public
    
    attr_accessor :id, :theme, :options # :nodoc:
    attr_reader   :map_type # :nodoc:

    # create a new map.
    # <tt>chart_id</tt> -- the name of the map stylesheet.
    # NOTE: If map_id is specified the framework will attempt to load the map styles
    # from public/maps/themes/theme_name/map_id.yml 
    def initialize( map_type, map_id=nil ) # :nodoc:
      raise "Invalid map type '#{map_type.inspect}'" unless Ziya::Maps::Base.map_types.include?( map_type )
      @id           = map_id
      @options      = @series = @points = @arcs = @lines = {}
      @line_colors  = @range_colors = @point_colors = @arc_colors = {}
      @theme        = default_theme
      @map_type     = map_type
      initialize_components
      load_helpers( Ziya.helpers_dir ) if Ziya.helpers_dir
    end
                
    # class component accessor...
    def self.components # :nodoc:
      @components
    end
        
    # default ZiYa theme
    def default_theme # :nodoc:
      File.join( Ziya.map_themes_dir, %w[default] )
    end
    
    # load up ERB style helpers
    def load_helpers( helper_dir ) # :nodoc:    
      Dir.foreach(helper_dir) do |helper_file| 
        next unless helper_file =~ /^([a-z][a-z_]*_helper).rb$/
        Ziya.logger.debug( ">>> ZiYa loading custom helper `#{$1}" )        
        # check rails env for autoloader ?
        if defined?(RAILS_ROOT) 
          require_dependency File.join(helper_dir, $1) 
        else
          require File.expand_path( File.join(helper_dir, $1) )
        end
        helper_module_name = "Ziya::" + $1.gsub(/(^|_)(.)/) { $2.upcase }        
        # helper_module_name = $1.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
        # if Ziya::Helpers.const_defined?(helper_module_name)
        Ziya.logger.debug( "Include module #{helper_module_name}")
        Ziya::Maps::Base.class_eval("include #{helper_module_name}") 
        # end
      end
    end    
                    
    # Add chart components to a given chart.  
    # 
    # The <tt>args</tt> must contain certain keys for the chart
    # to be displayed correctly.
    #
    # === Directives
    # * <tt>:series</tt> -- Specifies the data points for the map. This must be a hash
    #   of region, data pairs. Where the data is also a hash of attributes such as
    #   :name, :data, :hover, :url and :target.
    # * <tt>:range_colors</tt> -- Specifies the map of ranges of data values from the
    #   series to a color on the map. The range may be an exact value such as 10 or an
    #   actual range in the form of 1 - 10. The color must be an hexadecimal value of the
    #   form 'ff00ff'.
    # * <tt>:point_colors</tt> -- Specifies a map of valid color ranges to color the points
    #   on the map. Valid key/value pairs are a number or range for the key and an 
    #   associated color.
    # * <tt>:arc_colors</tt> -- Specifies a map of valid color ranges to color the arcs
    #   on the map. Valid key/value pairs are a number or range for the key and an 
    #   associated color.    
    # * <tt>:line_colors</tt> -- Specifies a map of valid color ranges to color the lines
    #   on the map. Valid key/value pairs are a number or range for the key and an 
    #   associated color.    
    # * <tt>:lines</tt> -- Specifies a map of lines to plot on the map. These are key/value pairs.
    #   The value represent the name of the line to be displayed. The value is a hash of attributes
    #   as follows: :start, the geocode location of the point, :stop, the geocode location of the arc to end at 
    #   :stroke, the thickness of the line and :data for the range value of the arc.
    # * <tt>:arcs</tt> -- Specifies a map of arcs to plot on the map. These are key/value pairs.
    #   The value represent the name of the arc to be displayed. The value is a hash of attributes
    #   as follows: :start, the geocode location of the point, :stop, the geocode location of the arc to end at 
    #   and :data for the range value of the arc.
    # * <tt>:points</tt> -- Specifies a map of points to plot on the map. These are key/value pairs.
    #   The value represent the name of the point to be displayed. The value is a hash of attributes
    #   as follows: :loc for the geocode location of the point and :data for the range value of the point.
    # * <tt>:theme</tt> -- Specify the use of a given named theme. The named theme must
    #   reside in a directory named equaly under your application public/charts/themes.
    #
    # === Examples
    # Colorize colorado and california on a US map
    #   my_map.add( :series, { :CO => { :name => "Colorado", :data => 1 }, :CA => { :name => "California", :data => 2 } ) 
    def add( *args )
      # TODO Validation categories = series, series = labels, etc...
      directive = args.shift
      case directive
        when :series
          if args.first.is_a?( Hash )
            points = args.shift || {}
            raise ArgumentError, "Must specify an hash of data points" if points.empty?
            @series = points
          else
            raise ArgumentError, "Must specify an hash of data points"
          end
        when :range_colors
          @range_colors = args.shift || {}
          raise ArgumentError, "You must specify a hash of data range/color pairs" if @range_colors.empty?          
        when :lines
          @lines = args.shift || {}
          raise ArgumentError, "You must specify a hash of lines attributes" if @lines.empty?
        when :line_colors
          @line_colors = args.shift || {}
          raise ArgumentError, "You must specify a hash of line range/color pairs" if @line_colors.empty?          
        when :arcs
          @arcs = args.shift || {}
          raise ArgumentError, "You must specify a hash of arcs attributes" if @arcs.empty?
        when :arc_colors
          @arc_colors = args.shift || {}
          raise ArgumentError, "You must specify a hash of arc range/color pairs" if @arc_colors.empty?          
        when :points
          @points = args.shift || {}
          raise ArgumentError, "You must specify a hash of points attributes" if @points.empty?
        when :point_colors
          @point_colors = args.shift || {}
          raise ArgumentError, "You must specify a hash of point range/color pairs" if @point_colors.empty?
        when :user_data
          key = args.first.is_a?(Symbol) ? args.shift : ""
          raise ArgumentError, "Must specify a key" if key.to_s.empty?
          value = args.shift
          # raise ArgumentError, "Must specify a value" if value.empty?
          @options[key] = value
        when :theme
          theme = args.first.is_a?(String) ? args.shift : ""
          raise ArgumentError, "Must specify a theme name" if theme.to_s.empty?          
          @theme = "#{Ziya.map_themes_dir}/#{theme}"
        else raise ArgumentError, "Invalid directive must be one of " + 
                                 ":series, :theme, :user_data"
      end 
    end
                
    # spews the map specification to a string
    def to_s
      out = ''
      @xml = Builder::XmlMarkup.new( :target => out )
      # Forces utf8 encoding on xml stream
      @xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"    
      if map_type == :us
        @xml.us_states do
          setup_lnf
          setup_series
        end
      else
        @xml.countrydata do
          setup_lnf
          setup_series
        end         
      end
      @xml.to_s.gsub( /<to_s\/>/, '' )
      out
    end                                       
    # dumps the map design to xml for client side consumption
    alias to_xml to_s  
                            
    # =========================================================================
    private

    # inflate object state based on object hierarchy
    def setup_state( state )
      override = self.class.name == state.class.name
      Base.components.each do |comp|
        instance_eval "#{comp}.merge( state.#{comp}, override ) unless state.#{comp}.nil?" 
      end
    end    
            
    # load yaml file associated with class if any
    def inflate( clazz, theme, instance=nil )
      class_name  = clazz.to_s.gsub( /Ziya::Maps/, '' ).ziya_underscore.gsub( /\//, '' )      
      class_name += '_map' unless class_name.match( /.?_map$/ ) 
      begin
        file_name = "#{theme}/#{class_name}"
        file_name = "#{theme}/#{instance}" unless instance.nil?
        Ziya.logger.debug ">>> Ziya attempt to load map stylesheet file '#{file_name}"        
        yml = IO.read( "#{file_name}.yml" )
        processed = erb_render( yml )
# puts ">>> Processed yaml", processed        
        load = YAML::load( processed )
        Ziya.logger.debug ">>> ZiYa [loading map styles] -- #{file_name}.yml"
# puts load.inspect        
        return load
      rescue SystemCallError => boom
        Ziya.logger.debug "ERROR #{boom}"
        ; # ignore if no style file...
      rescue => bang
        Ziya.logger.debug ">>> ZiYa -- Error encountered loading map file `#{file_name} -- #{bang}" 
        bang.backtrace.each { |l| Ziya.logger.debug( l ) }
      end
      nil
    end
        
    # parse erb template if any
    def erb_render(fixture_content)
      b = binding
      ERB.new(fixture_content).result b      
    end
                                                  
    # lay down the map data points and color ranges
    def setup_series
      @series.keys.sort{ |a,b| a.to_s <=> b.to_s }.each do |s|
        hash = @series[s]
        @xml.state( :id => s ) do |xml|
          hash.keys.sort{ |a,b| a.to_s <=> b.to_s}.each do |k|
            self.class.module_eval "xml.#{k}( '#{hash[k]}' )"
          end
        end
      end

      # lay down points if any?
      @points.keys.sort.each do |name|
        @xml.state( :id => "point" ) do |xml|
          xml.name( name )
          @points[name].keys.sort { |a,b| a.to_s <=> b.to_s }.each do |attr|
            self.class.module_eval "xml.#{attr}( '#{@points[name][attr]}' )"
          end
        end
      end

      # lay down points if any?
      @lines.keys.sort.each do |name|
        @xml.state( :id => "line" ) do |xml|
          xml.name( name )
          @lines[name].keys.sort { |a,b| a.to_s <=> b.to_s }.each do |attr|
            self.class.module_eval "xml.#{attr}( '#{@lines[name][attr]}' )"
          end
        end
      end

      @arcs.keys.sort.each do |name|
        @xml.state( :id => "arc" ) do |xml|
          xml.name( name )
          @arcs[name].keys.sort { |a,b| a.to_s <=> b.to_s }.each do |attr|
            self.class.module_eval "xml.#{attr}( '#{@arcs[name][attr]}' )"
          end
        end
      end
      
      # lay down range colors if any
      unless @range_colors.empty?
        @range_colors.each_pair do |range, color|
          @xml.state( :id => 'range' ) do
            @xml.data( range )
            @xml.color( color )
          end
        end
      end
      
      # lay down point range colors if any
      unless @point_colors.empty?
        @point_colors.each_pair do |range, color|
          @xml.state( :id => 'point_range' ) do
            @xml.data( range )
            @xml.color( color )
          end
        end
      end

      # lay down line range colors if any
      unless @line_colors.empty?
        @line_colors.each_pair do |range, color|
          @xml.state( :id => 'line_range' ) do
            @xml.data( range )
            @xml.color( color )
          end
        end
      end

      # lay down arc range colors if any
      unless @arc_colors.empty?
        @arc_colors.each_pair do |range, color|
          @xml.state( :id => 'arc_range' ) do
            @xml.data( range )
            @xml.color( color )
          end
        end
      end
      
    end
    
    # walk up class hierarchy to find chart inheritance classes
    def ancestors
      ancestors = self.class.ancestors.reverse
      allow = false
      ancestors.map do |k|    
        allow = true if k == Ziya::Maps::Base
        k if allow
      end.compact!
    end
        
    # load up look and feel data
    def load_lnf     
      unless @partial
        ancestors.each do |super_class|   
          # Load class instance prefs                
          if ( super_class == self.class )
            o = inflate( super_class, theme )
            setup_state( o ) unless o.nil? 
            # Now load instance prefs if any
            unless id.nil?
              o = inflate( super_class, theme, id )
              setup_state( o ) unless o.nil?        
            end
          # Otherwise load parent prefs...
          else
            o = inflate( super_class, theme, nil )
            setup_state( o ) unless o.nil?
          end
        end      
      end
      # Additional styles specified ? if so load them
      unless @options[:styles].nil?
        o = YAML::load( erb_render( @options[:styles] ) )
        setup_state( o ) unless o.nil?
      end
    end
        
    # generates xml for look and feel data
    def setup_lnf
      load_lnf
      Base.components.sort { |a,b| a.to_s <=> b.to_s }.each do |comp|           
        next unless self.send( comp ).configured?    
        instance_eval "#{comp}.flatten( @xml )"
      end
    end

    # load up the allowable map components
    def initialize_components
      # Setup instance vars
      Base.components.each do |comp|
        instance_var = lambda { |v| self.instance_eval{ instance_variable_set "@#{comp}", v } }
        instance_var.call(Ziya::Maps::Support.const_get( comp.to_s.ziya_classify ).new)
      end      
    end       
  end
end