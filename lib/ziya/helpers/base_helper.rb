require "ziya/utils/text"
require "ziya/ziya_helper"

module Ziya::Helpers
  module BaseHelper
    include Ziya::Utils::Text, Ziya::Helper

    # -------------------------------------------------------------------------
    # generates a swf chart path from the given url. Used as helper to embed 
    # chart 
    def chart_url( url, swf_chart_dir="/charts" )
      gen_composite_path( swf_chart_dir, url )
    end
    
    # -------------------------------------------------------------------------
    # indent yaml content vy multiples of 2 spaces
    def indent( multiple= 1 )
      "  " * multiple
    end

    # -------------------------------------------------------------------------
    # YAML Convenience for gauge class   
    def gauge( class_name )
      "--- #{clazz( class_name, 'Gauges' )}\n#{dials}" 
    end
    
    # -------------------------------------------------------------------------
    # YAML Convenience for gauge component declaration   
    def dial( comp_class, comp_name=nil )
      clazz = clazz( comp_class, "Gauges::Support" )
      comp_name ? "- :#{comp_name}: #{clazz}" : "- #{clazz}"
    end

    # -------------------------------------------------------------------------
    # YAML dials declaration   
    def dials
      "components: !omap"
    end
        
    # -------------------------------------------------------------------------
    # YAML Convenience for component declaration   
    def component( component_name )
      "#{component_name}: #{clazz component_name, :Components}"
    end
    alias :comp :component
    
    # -------------------------------------------------------------------------
    # YAML Convenience for draw component class   
    def drawing( class_name )
      clazz( class_name, :Components )
    end
    alias_method :filter_type, :drawing
    alias_method :area       , :drawing
    
    # -------------------------------------------------------------------------
    # YAML Convenience for chart class   
    def chart( class_name )
      "--- #{clazz( class_name, :Charts )}" 
    end
       
   # -------------------------------------------------------------------------
    # YAML Convenience for chart name setting       
    def clazz( class_name, module_name=nil )
      buff = "!ruby/object:Ziya::"
      buff << "#{module_name}::" unless module_name.nil?
      buff << "#{camelize(class_name.to_s)}"
      buff
    end               
  end
end