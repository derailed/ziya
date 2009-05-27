module Ziya::Gauges::Support
  class Base < Ziya::Charts::Support::Base
    include Ziya::YamlHelpers::Gauges
    
    # -----------------------------------------------------------------------
    # converts component to yaml style component for yaml parser consumption
    def to_comp_yaml( name, indent_multiplier=1 )
      buff = []
      tab  = indent( indent_multiplier )
      buff << "#{dial( self.class.name.demodulize, name )}"
      options.each_pair do |k,v|
        if v.is_a? YAML::Omap
          buff << "#{tab}#{indent}#{dials}"
          v.each do |name, comp|
            buff << "#{tab}#{indent(2)}#{dial( comp.class.name.demodulize, name )}"
            comp.options.each_pair { |k,v| buff << "#{tab}#{indent(4)}#{k}: #{v}"}
          end          
        else
          buff << "#{tab}#{indent(1)}#{k}: #{v}" if options[k] and !options[k].to_s.empty?
        end
      end
      buff.join( "\n" )
    end        
  end
end