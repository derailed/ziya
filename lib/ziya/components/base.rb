# -----------------------------------------------------------------------------
# Abstract class representing the base class for all chart preferences
# TODO Not getting parents inherited properties if defined as defaults
#
# TODO: Change attributes to be per class instance
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Components
  class Base # :nodoc:
    include Ziya::Utils::Text
        
    # class methods...
    class << self     
      # -----------------------------------------------------------------------
      # defines attribute accessors for a given component
      def has_attribute(*args) # :nodoc:
        class_name = self.to_s
        args.each do |attribute|          
          # add the attribute to the collection making sure to create a new array if one doesn't exist
          attributes[class_name] = [] if attributes[class_name].nil?
          attributes[class_name] << attribute
          # create the accessor methods for the attribute
          unless self.instance_methods.include?(attribute.to_s) && self.instance_methods.include?("#{attribute.to_s}=")
            self.module_eval "attr_accessor :#{attribute}"
          end
        end
      end
    
      # -----------------------------------------------------------------------
      # Class accessor. Retrieve class level preferences
      def attributes # :nodoc:
        @attributes ||= {}
      end
    end
  
    # -------------------------------------------------------------------------
    # initializes component from hash
    def initialize( opts={} )
      opts.each_pair do |k,v|
        self.send( "#{k}=", v )
      end
    end
  
    def ==( other )
      self.options.each_pair do |k,v|
        return false unless other.send( k ) == v
      end
    end  
    
    # -------------------------------------------------------------------------
    # merge attributes with overriden component
    def merge( parent_attributes, force=false )
      attributes_for(self).each do |attr|
        unless parent_attributes.send(attr).nil?
          send("#{attr}=", parent_attributes.send(attr)) 
        end
      end
    end
  
    def flatten( xml )
      hash  = has_sub_components
      clazz = demodulize( self.class.name )
      pref  = underscore( clazz )
      if hash and ! hash.empty?     
        self.class.module_eval <<-XML
         xml.#{pref}( #{options_as_string} ) do
          hash.each{ |k,v| v.flatten( xml ) }
         end
        XML
      else
        self.class.module_eval "xml.#{pref}( #{options_as_string} )"
      end
    end
    
    # -------------------------------------------------------------------------
    # handles simple flatten operation
    # def method_missing(method, *args)
    #   case method
    #     when :flatten
    #       xml   = args.first
    #       clazz = demodulize( self.class.name )
    #       pref  = underscore( clazz )
    #       self.class.module_eval "xml.#{pref}( #{options_as_string} )"
    #     else
    #       super.method_missing(method, *args)
    #   end
    # end
  
    # -------------------------------------------------------------------------
    # checks if a give component properties have been set. 
    # return true if one or more props have been set. False otherwise...
    def configured?
      !options.empty?
    end
      
    # -------------------------------------------------------------------------
    # Checks if one of the options is an array
    def has_sub_components
      options.each_pair do |k, v|
        return v if v.is_a? YAML::Omap
      end
      nil
    end
    
    # -------------------------------------------------------------------------
    # calls all attribute methods and gather the various props into a hash
    def options
      options = {}
      attributes_for(self).each do |p|
        option = self.send(p.to_sym)   
        options[p] = option unless option.nil?
      end
      options
    end
    
    # -------------------------------------------------------------------------
    # Turns options hash into string representation
    def options_as_string
      buff = []
      opts = options
      opts.keys.sort{ |a,b| a.to_s <=> b.to_s }.each do |k|
        value = opts[k]
        buff << sprintf( ":%s => '%s'", k, value.to_s ) if !value.nil? and !value.is_a? YAML::Omap
      end      
      buff.join( "," )
    end
    
    # -------------------------------------------------------------------------
    # fetch attributes for a give component
    def attributes_for( an_instance )
      attrs = self.class.attributes[an_instance.class.name] 
      raise "Unable to get attributes for #{an_instance}" unless attrs
      attrs
    end
    
    # =========================================================================
    private
         
  end
end