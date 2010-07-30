require 'ziya/yaml_helpers/gauges'
require 'ziya/html_helpers/gauges'
require 'erb'
require 'cgi'

module Ziya::Gauges
  class Base
    include Ziya::YamlHelpers::Gauges, Ziya::HtmlHelpers::Gauges

    attr_accessor :license, :design_id
    attr_reader   :type, :components
    attr_reader   :options
    
    def initialize( license, design_id )
      @license   = license
      @design_id = design_id
      
      # load up associated helper
      loaded = load_helper( Ziya.helpers_dir ) if Ziya.helpers_dir
      Ziya.logger.debug( ">>> ZiYa -- no helper for gauge `#{design_id}" ) unless loaded

      # init defaults
      @options = default_options      
    end
          
    # -------------------------------------------------------------------------
    # provides for overiding basic functionality
    #
    # <tt>gauge_color</tt>::   Legend color
    # <tt>legend_color</tt>::  Gauge color
    def set_preferences( opts={} )
      options.merge!( opts )
    end

    # -------------------------------------------------------------------------    
    # render gauge to xml
    def to_xml
      render_xml
    end    
   
    # =========================================================================
    protected

      # inject update behavior
      def render_extra_components
        if options[:url]
          Ziya::Gauges::Support::Update.new(
            :url        => options[:url],
            :retry      => options[:retry] || 0,
            :timeout    => options[:timeout] || 30,
            :delay_type => options[:delay_type] || 1,
            :delay      => options[:delay] || 30 ).flatten( @xml )
        end
      end

      # -------------------------------------------------------------------------
      # setup thermometer default options
      def default_options
        { 
          :x            => 20,
          :y            => 20,
          :gauge_color  => "ff0000",
          :legend_color => "cc0000",
        }
      end
               
    # =========================================================================     
    private

      # retrieve bundled design directory
      def bundled_designs_dir
        Ziya.path( %w[resources gauges designs] )
      end
      
      # -----------------------------------------------------------------------
      # Load up ERB style helpers
      def load_helper( helper_dir )
        Dir.foreach(helper_dir) do |helper_file|
          unless helper_file =~ /^(#{design_id}_helper).rb$/ or helper_file =~ /^(base_helper).rb$/
            next
          end
          Ziya.logger.debug( ">>> ZiYa loading custom helper `#{$1}" )
          # BOZO !! This will only work in rails ??
          if defined? RAILS_ROOT
            require_dependency File.join(helper_dir, $1) 
          else
            require File.join(helper_dir, $1)
          end
          helper_module_name = "Ziya::" + $1.gsub(/(^|_)(.)/) { $2.upcase }        
          # helper_module_name = $1.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
          Ziya.logger.debug( "Include module #{helper_module_name}")
          Ziya::Gauges::Base.class_eval("include #{helper_module_name}") 
          true
        end
        false
      end        

      # -----------------------------------------------------------------------
      # merge components with user overrides
      def merge_comps( original, override )
        override.each do |k,v|
          if original.has_key? k
            original[k] = v
          else
            original << [k,v]
          end
        end
      end
      
      # -----------------------------------------------------------------------
      # renders design components
      def render_components
        # First check bundled design dir for std design
        std_design = inflate( self, bundled_designs_dir, design_id )
        # Now check for user overrides
        usr_design = inflate( self, Ziya.designs_dir, design_id )
                
        design = usr_design
        if std_design and usr_design
          design = std_design
          merge_comps( design.components, usr_design.components )
          # design.components.merge!( usr_design.components )
        elsif std_design
          design = std_design
        end        
# Ziya.logger.info "!!!! Design #{design_id} -- \n#{design.to_yaml}"
        # flatten components to xml
        design.components.each do |name, value|
# Ziya.logger.debug "Processing #{name}"          
          value.flatten( @xml )
        end            
      end
      
      # -----------------------------------------------------------------------
      # renders chart to xml
      def render_xml
        out = ''
        @xml = Builder::XmlMarkup.new( :target => out )
        @xml.gauge do
          @xml.license( @license ) unless @license.nil?
          render_extra_components          
          render_components
        end
        @xml.to_s.gsub( /<to_s\/>/, '' )
        out
      end

      # -----------------------------------------------------------------------
      # Parse erb template if any
      def erb_render( yml )
        # b = binding
        ERB.new( yml ).result binding   
      end
            
      # -----------------------------------------------------------------------
      # Load yaml file associated with class if any
      def inflate( clazz, designs_dir, design )
        class_name  = clazz.to_s.ziya_demodulize.ziya_underscore
        begin
          file_name = "#{designs_dir}/#{design}.yml"
          Ziya.logger.debug ">>> ZiYa attempt to load design file '#{file_name}"    
          return nil unless File.exists?( file_name )          
          yml = IO.read( file_name )
# Ziya.logger.info ">>> Unprocessed yaml...\n#{yml}\n"        
          processed = erb_render( yml )
# Ziya.logger.info ">>> Processed yaml...\n#{processed}"
          load = YAML::load( processed )
          Ziya.logger.debug ">>> ZiYa successfully loaded design file `#{file_name}"        
          return load
        rescue SystemCallError => boom
          Ziya.logger.debug boom
        rescue => bang
          Ziya.logger.info ">>> ZiYa -- Error encountered loading design file `#{file_name} -- #{bang}" 
          bang.backtrace[0..3].each { |l| Ziya.logger.debug( l ) }
        end
        nil
      end    
  end
end