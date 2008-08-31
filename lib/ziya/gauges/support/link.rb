# -----------------------------------------------------------------------------
# Create a link on a component
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/gauges/support/base'

module Ziya::Gauges::Support
  class Link < Base  
    has_attribute :components
    
    # has_attribute :areas
    # attr_accessor :areas

    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    # def flatten( xml )      
    #   xml.link do  
    #     areas.each { |area| area.flatten( xml ) } if areas and !areas.empty?
    #   end
    # end
                  
  end  
end