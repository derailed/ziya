require 'ziya/yaml_helpers/gauges'

module Ziya::Maps::Support
  class Base < Ziya::Charts::Support::Base
    include Ziya::YamlHelpers::Gauges

    # flatten component to xml
    def flatten( xml )
      xml.state( :id => to_component_id ) do |state|
        options.keys.sort { |a,b| a.to_s <=> b.to_s }.each{ |k| self.class.module_eval "xml.#{k}( '#{options[k]}' )" }
      end
    end
    
    # -----------------------------------------------------------------------
    # converts component to yaml style component for yaml parser consumption
    def to_comp_yaml( indent_multiplier=1 )
      buff = []
      tab  = indent( indent_multiplier )
      buff << "#{dial( self.class.name.ziya_demodulize, name )}"      
      options.each_pair do |k,v|
        buff << "#{tab}#{k}: #{v}" if options[k] and !options[k].to_s.empty?
      end
      buff.join( "\n" )
    end        
    
    protected

      # converts class name to underscore name    
      def to_component_id
        class_name = self.class.name.ziya_underscore.split( "/" ).last
      end

  end
end