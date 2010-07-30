require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class Range < Base
    class << self
      def define_mappings( mappings )
        @mappings = mappings
      end
      
      def mappings
        @mappings
      end
    end
    
    has_attribute   :color, :level
    define_mappings :level => :data
    
    def flatten( xml )
      xml.state( :id => to_component_id ) do
        options.keys.sort { |a,b| a.to_s <=> b.to_s }.each { |k| self.class.module_eval "xml.#{find_key_for_attr(k)}( '#{options[k]}' )" }
      end
    end
    
    private
            
      def find_key_for_attr( k )
        return Range.mappings[k] if Range.mappings.has_key? k 
        k
      end        
  end
end