# -----------------------------------------------------------------------------
# Sets up chart elements color
#
# Sets the colors to use for the chart series.
#
# <tt></tt>:
#
# See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=series_color
# for additional documentation, examples and futher detail.
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Components
  class SeriesColor < Base    
    has_attribute :colors
  
    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element    
    def flatten( xml )
      unless colors.nil?
        xml.series_color do
          if colors.is_a? String
            cols = colors.split( "," )
            cols.each { |c| xml.color( c.strip ) }
          elsif colors.respond_to? :each
            colors.each { |c| xml.color( c ) }
          else
            xml.color( colors )
          end
        end   
      end
    end
  end
end