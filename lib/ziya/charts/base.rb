# -----------------------------------------------------------------------------
# == Ziya::Charts::Base
#
# Charts mother ship
#
# TODO !! Match helpers with chart class name
# TODO !! Add accessor for specifying refresh look and data links on comps
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
require 'ziya/helpers/base_helper'
require 'yaml'

# TODO Figure out the equiv require_dep for merb if any ??
# TODO Refact and clean up. 
module Ziya::Charts
  # The mother ship of all charts. This class figures out how to generate the 
  # correct xml to render the chart on the client side. This class handles loading
  # style sheets and chart helper for the helper directory specified during 
  # initialization.
  class Base
    # blee blee
    include Ziya::Helpers::BaseHelper
    
    # =========================================================================                
    protected      
      # defines the various chart components
      def self.declare_components # :nodoc:
        @components = [
          :axis_category, :axis_ticks, :axis_value, 
          :chart_rect, :chart_border, :chart_grid_h, :chart_grid_v,
          :chart_transition, :chart_label, :chart_guide, :legend,
          :filter, :draw, 
          :series_color, :series, :series_explode, 
          :chart_pref, :scroll,
          :update, :link_data, :link, :context_menu]                              
        @components.each { |a| attr_accessor a }      
      end    
      declare_components

    # =========================================================================    
    public
    
    attr_accessor :license, :id, :theme, :options, :size # :nodoc:
    attr_reader   :type # :nodoc:

    # create a new chart.
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.
    # NOTE: If chart_id is specified the framework will attempt to load the chart styles
    # from public/themes/theme_name/chart_id.yml 
    def initialize( license=nil, chart_id=nil ) 
      @id          = chart_id
      @license     = license
      @options     = {}
      @series_desc = []
      @theme       = default_theme
      @render_mode = Base.all_styles
      initialize_components
      load_helpers( Ziya.helpers_dir ) if Ziya.helpers_dir
    end
                
    # class component accessor...
    def self.components # :nodoc:
      @components
    end
    
    # don't render stylesheets just gen code for chart stylesheet and data
    def self.data_only() 1; end
    
    # renders everything
    def self.all_styles() 0; end
    
    # -------------------------------------------------------------------------
    # Default ZiYa theme
    def default_theme # :nodoc:
      File.join( Ziya.themes_dir, %w[default] )
    end
    
    # -------------------------------------------------------------------------
    # Load up ERB style helpers
    def load_helpers( helper_dir ) # :nodoc:    
      Dir.foreach(helper_dir) do |helper_file| 
        next unless helper_file =~ /^([a-z][a-z_]*_helper).rb$/
        Ziya.logger.debug( ">>> ZiYa loading custom helper `#{$1}" )        
        require_dependency File.join(helper_dir, $1)        
        helper_module_name = "Ziya::" + $1.gsub(/(^|_)(.)/) { $2.upcase }        
        # helper_module_name = $1.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
        # if Ziya::Helpers.const_defined?(helper_module_name)
        Ziya.logger.debug( "Include module #{helper_module_name}")
        Ziya::Charts::Base.class_eval("include #{helper_module_name}") 
        # end
      end
    end    
                    
    # Add chart components such as x and y axis labels, data points and chart 
    # labels.     
    # 
    # Example:
    #   my_chart = Ziya::Charts::Bar.new
    #   my_chart.add( :axis_category_text, ['2004', '2005', '2006'] ) 
    #   my_chart.add( :series, 'series A', [ 10, 20, 30], [ '10 dogs', '20 cats', '30 rats'] )
    #   my_chart.add( :axis_value_label, [ 'my dogs', 'my cats', 'my rats'] )
    #   my_chart.add( :user_data, :mykey, "Fred" )
    #
    #   This will display a bar chart with x axis ticks my dogs, my cats, my fox and
    #   y axis values 2004, 2005, 2006. The labels on the bars will read 10 dogs, 
    #   20 cats, 30 rats
    #
    # The <tt>args</tt> must contain certain keys for the chart
    # to be display correctly. The keys are defined as follows:
    # <tt>:axis_category_text</tt>::   Array of strings representing the x/y axis
    #                                  ticks dependending on the chart type. This 
    #                                  value is required.
    # <tt>:axis_category_label</tt>::  Array of strings representing the x axis
    #                                  labels. This is supported only for Scatter and Bubble charts.
    #                                  This value is optional. Specify nil for no label change.    
    # <tt>:series</tt>::               Specifies the series name and chart data points.
    #                                  The series name will be used to display chart legends.
    #                                  You must have at least one of these tag defined.
    #                                  You may also specify an array of strings to identifies the 
    #                                  custom labels that will be used on top of the chart 
    #                                  elements
    # <tt>:axis_value_label</tt>::     Array of strings representing the ticks on the x/y
    #                                  axis depending on the chart type. This is symmetrical
    #                                  to the <tt>axis_category_label</tt> tag for the opposite
    #                                  chart axis. Specify nil for no label change.
    # <tt>:user_data</tt>::            Used to make user data available to the ERB templates in
    #                                  the chart stylesheet yaml file. You must specify a key symbol
    #                                  and an ad-hoc value. The key will be used with the @options
    #                                  hash to access the user data.  
    # <tt>:composites</tt>::           Embeds multiple charts within the given chart via the draw image component.
    # <tt>:chart_types</tt>::          Specify the chart types per series. This option should                        
    #                                  only be used with Mixed Charts !!    
    # <tt>:theme</tt>::                Specify the use of a given theme
    #
    def add( *args )
      # TODO Validation categories = series, series = labels, etc...
      directive = args.shift
      case directive
        when :axis_category_text
          categories = args.first.is_a?(Array) ? args.shift : []
          raise ArgumentError, "Must specify an array of categories" if categories.empty?
          categories.insert( 0, nil )
          @options[directive] = categories
        when :axis_category_label
          labels = args.first.is_a?(Array) ? args.shift : []
          raise ArgumentError, "Must specify an array of category labels" if labels.empty?
          @options[directive] = labels          
        when :composites
          composites = args.first.is_a?(Array) ? args.shift: []
          raise ArgumentError, "Must specify an array of urls for the composite chart(s)" if composites.empty?
          @options[directive] = composites
        when :axis_value_label
          values = args.first.is_a?(Array) ? args.shift : []
          raise ArgumentError, "Must specify an array of values" if values.empty?
          @options[directive] = values
        when :series
          legend = args.first.is_a?(String) ? args.shift : ""
          if args.first.is_a?( Array )
            points = args.shift || []
            raise ArgumentError, "Must specify an array of data points" if points.empty?
            points.insert( 0, legend )
            @series_desc << points
          else
            raise ArgumentError, "Must specify an array of data points"
          end
        when :user_data
          key = args.first.is_a?(Symbol) ? args.shift : ""
          raise ArgumentError, "Must specify a key" if key.to_s.empty?
          value = args.shift
          # raise ArgumentError, "Must specify a value" if value.empty?
          @options[key] = value
        when :styles
          styles = args.first.is_a?(String) ? args.shift : ""
          raise ArgumentError, "Must specify a set of styles" if styles.to_s.empty?          
          @options[directive] = styles   
        when :chart_types
          types = args.first.is_a?(Array) ? args.shift : []
          raise ArgumentError, "Must specify a set of chart types" if types.to_s.empty?          
          @options[directive] = types                        
        when :theme
          theme = args.first.is_a?(String) ? args.shift : ""
          raise ArgumentError, "Must specify a theme name" if theme.to_s.empty?          
          @theme = "#{Ziya.themes_dir}/#{theme}"
        when :mode
          @render_mode = args.first.is_a?(Integer) ? args.shift : -1
          raise ArgumentError, "Must specify a valid generation mode" if @render_mode == -1          
        else raise ArgumentError, "Invalid directive must be one of " + 
                                 ":axis_category_text, :axis_value, :series, :user_data"
      end 
    end
                
    # spews the graph specification to a string
    # <tt>:partial</tt>::  You can specify this option to only update parts of the charts
    #                      that have actually changed. This is useful for live update and
    #                      link update where you may not need to redraw the whole chart.
    def to_s( options={} )
      @partial = options[:partial] || false
      @xml     = Builder::XmlMarkup.new
      # Forces utf8 encoding on xml stream
      @xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
      @xml.chart do
        @xml.license( @license ) unless @license.nil?
        if render_parents?
          if !@type.nil?
            @xml.chart_type( @type )              
          elsif @options[:chart_types].is_a? Array and ! @options[:chart_types].empty?
            @xml.chart_type do   
              @options[:chart_types].each { |type| @xml.string( type ) }   
            end
          end
        end
        setup_lnf
        setup_series
      end
      @xml.to_s.gsub( /<to_s\/>/, '' )
    end                                       
    # dumps the chart design to xml for client side consumption
    alias to_xml to_s  
                            
    # =========================================================================
    private

    # -------------------------------------------------------------------------
    # Inflate object state based on object hierarchy
    def setup_state( state )
      override = self.class.name == state.class.name
      Base.components.each do |comp| 
        instance_eval "#{comp}.merge( state.#{comp}, override ) unless state.#{comp}.nil?" 
      end
    end    
            
    # -------------------------------------------------------------------------
    # Load yaml file associated with class if any
    def inflate( clazz, theme, instance=nil )
      class_name  = underscore(clazz.to_s.gsub( /Ziya::Charts/, '' )).gsub( /\//, '' )      
      class_name += '_chart' unless class_name.match( /.?_chart$/ ) 
      begin
        file_name = "#{theme}/#{class_name}"
        file_name = "#{theme}/#{instance}" unless instance.nil?
        Ziya.logger.debug ">>> Ziya attempt to load style sheet file '#{file_name}"        
        yml = IO.read( "#{file_name}.yml" )
# Ziya.logger.debug( yml )        
        load = YAML::load( erb_render( yml ) )
        Ziya.logger.info ">>> ZiYa [loading styles] -- #{file_name}.yml"        
        return load
      rescue SystemCallError => boom
        ; # ignore if no style file...
      rescue => bang
        Ziya.logger.error ">>> ZiYa -- Error encountered loading file `#{file_name} -- #{bang}" 
        bang.backtrace.each { |l| Ziya.logger.error( l ) }
      end
      nil
    end
        
    # -------------------------------------------------------------------------
    # Parse erb template if any
    def erb_render(fixture_content)
      b = binding
      ERB.new(fixture_content).result b      
    end
                              
    # -------------------------------------------------------------------------
    # Generates xml element for given data set
    # TODO Lame ! Refact...
    def gen_data_points( series_name, labels=nil )
      values  = @options[series_name]
      labels.insert( 0, nil ) if labels
      @xml.row do
        if values.respond_to? :each
          values.each do |c|
            if c.nil?
              @xml.null 
            elsif c.instance_of? String 
              if labels and !labels.empty?
                label = labels.shift                
                if label
                  @xml.string( :label => label ) { |x| x.text!( c ) }
                else
                  @xml.string( c )
                end
              else
                @xml.string( c )
              end
            elsif c.respond_to? :zero?
              if labels and !labels.empty?
                label = labels.shift
                if label
                  @xml.number( :label => label ) { |x| x.text!( c.to_s ) } 
                else
                  @xml.number( c )
                end
              else
                @xml.number( c )
              end
            end
          end
        else
          @xml.string( values )
        end
      end              
    end
            
    # # -------------------------------------------------------------------------
    # # Generates custom axis values
    # def gen_axis_value_text( values )
    #   return if values.nil? or values.empty?
    #   @xml.axis_value_text do 
    #     values.each { |v| @xml.string( v ) }
    #   end
    # end
        
    # # -------------------------------------------------------------------------
    # # Check if the series are named
    # def named_series?( names )
    #   names.each do |name|
    #     next unless name.to_s.index( 'series_' )
    #     return @options[name][0].instance_of?(String) if @options[name] and !@options[name].empty?
    #   end
    #   false
    # end
    
    # # -------------------------------------------------------------------------
    # # Check if the options have custom labels ie :label_xxx tag
    # def has_labels( names )
    #   names.each do |name|
    #     next unless name.to_s.index( 'labels_' )
    #     return @options[name].size if @options[name] and !@options[name].empty?
    #   end
    #   0
    # end    
    
    # # -------------------------------------------------------------------------
    # # Generates custom labels
    # def gen_labels( series_name, is_default=false )
    #   cltn  = @options[series_name]
    #   cltn.insert( 0, nil ) unless is_default
    #   @xml.row do        
    #     cltn.each { |c| ((c.nil? or c.to_s.empty?) ? @xml.null : @xml.string( c )) }
    #   end              
    # end    
    
    # # ------------------------------------------------------------------------
    # # Generates default series labels
    # def gen_default_labels( size )
    #   labels = []
    #   size.times { |i| labels << nil }
    #   @xml.row do        
    #     labels.each { |c| @xml.null }
    #   end     
    # end                

    # ------------------------------------------------------------------------
    # generates chart data row
    # TODO Validate options !!
    def gen_row_data( value, opts=nil )
      if value.instance_of? String
        gen_string_data( value, opts )
      elsif value.respond_to? :zero?
        gen_number_data( value, opts )
      end        
    end
    
    # -------------------------------------------------------------------------
    # generates string chart_value
    def gen_string_data( value, opts )
      if opts
        @xml.string( opts ) { |x| x.text!( value ) }
      else
        @xml.string( value )
      end
    end
    
    # -------------------------------------------------------------------------
    # generates number chart_value
    def gen_number_data( value, opts )
      if opts
        @xml.number( opts ) { |x| x.text!( value.to_s ) }
      else
        @xml.number( value )
      end
    end
    
    # -------------------------------------------------------------------------
    # generates chart data points    
    # BOZO !! Check args on hash
    def gen_chart_data( series )
      @xml.row do
        series.each do |row|      
          if row.nil?
            @xml.null 
          elsif row.instance_of? Hash
            value = row.delete( :value )
            gen_row_data( value, row )
          else
            gen_row_data( row )
          end
        end
      end        
    end
    
    # -------------------------------------------------------------------------
    # Lay down graph data points and labels if any
    # TODO Validate series sizes/label sizes
    def setup_series
      raise "You must specify an axis_category_text with your series." if !@series_desc.empty? and ! @options[:axis_category_text]
      
      if @options[:axis_category_text]
        @xml.chart_data do 
          gen_data_points( :axis_category_text )
          # render xml for each series
          @series_desc.each do |series|
            gen_chart_data( series )
          end
        end  
      end
      
      # display category labels if any
      if @options[:axis_category_label]
        @xml.axis_category_label do
          @options[:axis_category_label].each do |label|
            label ? @xml.string( label ) : @xml.null
          end
        end
      end
      
      # display axis value labels if any
      if @options[:axis_value_label]
        @xml.axis_value_label do
          @options[:axis_value_label].each do |label|
            label ? @xml.string( label ) : @xml.null
          end
        end
      end
      
    end
    
    # -------------------------------------------------------------------------
    # Walk up class hierarchy to find chart inheritance classes
    def ancestors
      ancestors = self.class.ancestors.reverse
      allow = false
      ancestors.map do |k| 
        allow = true if k == Ziya::Charts::Base
        k if allow
      end.compact!
    end
    
    # -------------------------------------------------------------------------
    # Check if we should do the all monty or just render the instance styles
    def render_parents?      
      (@render_mode == Base.all_styles)
    end
    
    # -------------------------------------------------------------------------
    # Load up look and feel data
    def load_lnf     
      unless @partial
        ancestors.each do |super_class|
          o = nil
          if ( super_class == self.class )
            # Load class instance prefs
            o = inflate( super_class, theme ) if render_parents?
            setup_state( o ) unless o.nil? 
            # Now load instance prefs if any
            unless id.nil?
              o = inflate( super_class, theme, id )
              setup_state( o ) unless o.nil?        
            end
          else
            o = inflate( super_class, theme, nil ) if render_parents?
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
        
    # -------------------------------------------------------------------------
    # Generates xml for look and feel data
    def setup_lnf
      load_lnf
      unless @partial
        Base.components.each do |comp|          
          next unless self.send( comp ).configured? # => Don't include non configured components
          if comp == :draw
            instance_eval "#{comp}.flatten( @xml, @options[:composites] )"
          else
            instance_eval "#{comp}.flatten( @xml )"
          end
        end
      end      
    end

    # -------------------------------------------------------------------------  
    def initialize_components
      # Setup instance vars
      Base.components.each do |comp|
        instance_var = lambda { |v| self.instance_eval{ instance_variable_set "@#{comp}", v } }
        instance_var.call(Ziya::Components.const_get(classify(comp)).new)
      end      
    end       
  end
end
