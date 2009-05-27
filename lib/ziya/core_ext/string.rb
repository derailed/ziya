# -----------------------------------------------------------------------------
# Various text utils. Yes indeed lifted from Inflector.
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
class String
  # Pulled from the Rails Inflector class and modified slightly to fit our needs.
  def camelize_it()
    self.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
  end

  # Same as Rails Inflector but eliminating inflector dependency
  def underscore
    self.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
    downcase
  end

  # Pulled from the Rails Inflector class and modified slightly to fit our needs.
  def classify
    self.sub(/.*\./, '').camelize_it
  end
  
  # strip out module name and return bare class name
  def demodulize
    self.gsub( /^.*::/, '' )
  end    
end