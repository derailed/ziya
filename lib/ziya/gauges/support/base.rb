module Ziya::Gauges::Support
  class Base < Ziya::Charts::Support::Base
    include Ziya::YamlHelpers::Gauges
    
    # -----------------------------------------------------------------------
    # converts component to yaml style component for yaml parser consumption
    def to_comp_yaml( name, indent_multiplier=1 )
      buff = []
      tab  = indent( indent_multiplier )
      buff << "#{dial( self.class.name.ziya_demodulize, name )}"
      options.each_pair do |k,v|
        if v.is_a? YAML::Omap
          buff << "#{tab}#{indent}#{dials}"
          v.each do |comp_name, comp|
            buff << "#{tab}#{indent(2)}#{dial( comp.class.name.ziya_demodulize, comp_name )}"
            comp.options.each_pair { |key,val| buff << "#{tab}#{indent(4)}#{key}: #{val}"}
          end          
        else
          buff << "#{tab}#{indent(1)}#{k}: #{v}" if options[k] and !options[k].to_s.empty?
        end
      end
      buff.join( "\n" )
    end        
  end
end