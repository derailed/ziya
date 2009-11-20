require "ziya/core_ext/string"

module Ziya
  module YamlHelpers
    module Base
      # indent yaml content vy multiples of 2 spaces
      def indent( multiple= 1 )
        "  " * multiple
      end
  
      # generates a yaml class declaration
      def clazz( class_name, module_name=nil ) #:nodoc:
        buff = "!ruby/object:Ziya::"
        buff << "#{module_name}::" unless module_name.nil?
        buff << class_name.to_s.ziya_camelize
        buff
      end      
    end
  end
end