require "ziya/utils/text"
require "ziya/ziya_helper"

module Ziya::Helpers
  module BaseHelper
    include Ziya::Utils::Text, Ziya::Helper

    # Defines various helpers to assist in writing ZiYa yaml stylesheets.

    # generates a swf chart path from the given url. Used as helper to embed a chart
    # within a chart
    # ==== Example
    #   <%= chart_url( chart_1_path, "fred" ) %>
    #
    #  => /charts/charts.swf?library_path=/charts/charts_library&xml_source=http://fred/load_chart_1.xml&chart_id=fred
    def chart_url( url, swf_chart_dir="/charts", id=nil )
      gen_composite_path( swf_chart_dir, url, id )
    end
    
    # indent yaml content vy multiples of 2 spaces
    def indent( multiple= 1 )
      "  " * multiple
    end

    # generates a gauge yaml class declaration
    # ==== Example
    #  <%= gauge :thermo %>
    #
    #  produces:
    #
    #  --- !ruby/object:Ziya::Gauges::Thermo
    #    components: !omap
    def gauge( class_name )
      "--- #{clazz( class_name, 'Gauges' )}\n#{dials}" 
    end
    
    # generates a gauge element declaration
    # ==== Example
    #  <%= dial :rect %>
    #  => --- !ruby/object:Ziya::Gauges::Support::Rect
    def dial( comp_class, comp_name=nil )
      clazz = clazz( comp_class, "Gauges::Support" )
      comp_name ? "- :#{comp_name}: #{clazz}" : "- #{clazz}"
    end

    # generates a yaml hash of dials
    # ==== Example
    #  <%= dials %>
    #  => components: !omap
    def dials
      "components: !omap"
    end
        
    # generates a component yaml class declaration
    # ==== Example
    #  <%= component :axis_category %>
    #  => axis_category: --- !ruby/object:Ziya::Components::AxisCategory
    def component( component_name )
      "#{component_name}: #{clazz component_name, :Components}"
    end
    alias :comp :component
    
    # generates a drawing yaml class declaration
    # ==== Example
    #  <%=drawing :rect %>
    #  => --- !ruby/object:Ziya::Components::Rect
    def drawing( class_name )
      clazz( class_name, :Components )
    end
    alias_method :filter_type, :drawing
    alias_method :area       , :drawing
    
    # generates a yaml chart declaration
    # ==== Example
    #  <%= chart :bar %>
    #  => --- !ruby/object:Ziya::Charts::Bar
    def chart( class_name )
      "--- #{clazz( class_name, :Charts )}" 
    end
      
    private
    
      # generates a yaml class declaration
      def clazz( class_name, module_name=nil ) #:nodoc:
        buff = "!ruby/object:Ziya::"
        buff << "#{module_name}::" unless module_name.nil?
        buff << "#{camelize(class_name.to_s)}"
        buff
      end               
  end
end