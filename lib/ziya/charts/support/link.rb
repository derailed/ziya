# -----------------------------------------------------------------------------
# Sets up clickable areas on the chart.
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Charts::Support
  # Sets up clickable areas on the chart.
  #
  # Holds any number of areas, each defining a rectangle and a URL to go to when the user
  # clicks inside the rectangle. This can also be used to make refresh or print buttons.
  #
  # <tt></tt>:
  #
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=link
  # for additional documentation, examples and futher detail.  
  class Link < Base  
    has_attribute :areas
                     
    # -------------------------------------------------------------------------
    # Override merge attributes enhance component definitions vs override
    def merge( parent_attributes, override=false )
      comps = send( :areas ) || []
      comps = comps + parent_attributes.send( :areas ) if parent_attributes.send( :areas )
      send( "areas=", comps )
    end
                     
    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    def flatten( xml )
      if areas
        xml.link do
          areas.each { |area| area.flatten( xml ) }
        end
      end
    end
  end
end