# -----------------------------------------------------------------------------
# Generates necessary xml for 3D pie chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts  
  class PieThreed < Base
    # Creates a 3D pie chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.          
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "3d pie"      
    end
  end
end