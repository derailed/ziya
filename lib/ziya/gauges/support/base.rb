module Ziya::Gauges::Support
  class Base < Ziya::Components::Base
    include Ziya::Helpers::BaseHelper
    
    # -----------------------------------------------------------------------
    # converts component to yaml style component for yaml parser consumption
    def to_comp_yaml( name, indent_multiplier=1 )
      buff = []
      tab  = indent( indent_multiplier )
      buff << "#{dial( demodulize( self.class.name ), name )}"
      options.each_pair do |k,v|
        if v.is_a? YAML::Omap
          buff << "#{tab}#{indent}#{dials}"
          v.each do |name, comp|
            buff << "#{tab}#{indent(2)}#{dial( demodulize(comp.class.name), name )}"
            comp.options.each_pair { |k,v| buff << "#{tab}#{indent(4)}#{k}: #{v}"}
          end          
        else
          buff << "#{tab}#{indent(1)}#{k}: #{v}" if options[k] and !options[k].to_s.empty?
        end
      end
    
      # if ( self.respond_to? :dials )
      #   buff << "#{tab}dials:"
      #   for dial in dials do
      #     buff << "#{tab}#{dial( demodulize( dial.class.name ) )}"
      #     dial.options.each_pair { |k,v| buff << "#{tab}#{tab}#{k}: #{v}"}
      #   end
      # end
      buff.join( "\n" )
    end        
  end
end