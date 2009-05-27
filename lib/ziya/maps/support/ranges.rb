# -----------------------------------------------------------------------------
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Maps::Support
  class Ranges < Base          
    has_attribute :ranges
                         
    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    def flatten( xml )
      ranges.each do |range|
        range["range"].flatten( xml )
      end
    end
    
  end
end