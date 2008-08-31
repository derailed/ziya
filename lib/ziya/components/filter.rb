# -----------------------------------------------------------------------------
# Sets various filters for enhancing charts look and feel
#
# Holds any number of filters. such as bevel, shadow etc. You must specify
# and id so that other drawable component can use the filters
#
# Author:: Fernand
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the various filters that can be reused across components ie blur, bevel, glow, etc...
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=filter
  # for additional documentation, examples and futher detail.      
  class Filter < Base      
    has_attribute :filters
                         
    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    def flatten( xml )
      if filters
        xml.filter do 
          filters.each { |comp| comp.flatten( xml ) }
        end
      end
    end
  end
end