# -----------------------------------------------------------------------------
# == Ziya::Utils::Text
#
# TODO !! Just make this a core extension to String already...
#
# Various text utils. Yes indeed lifted from Inflecto to remove Inflector 
# dependencies...
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Utils
  module Text
    # Pulled from the Rails Inflector class and modified slightly to fit our needs.
    def camelize(string)
      string.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
    end

    # Same as Rails Inflector but eliminating inflector dependency
    def underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
      downcase
    end

    # Pulled from the Rails Inflector class and modified slightly to fit our needs.
    def classify(string)
      camelize(string.to_s.sub(/.*\./, ''))
    end
    
    # strip out module name and return bare class name
    def demodulize( clazz )
      clazz.gsub( /^.*::/, '' )
    end
    
  end  
end