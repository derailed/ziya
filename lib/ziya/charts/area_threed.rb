# -----------------------------------------------------------------------------
# Generates necessary xml for a 3d area chart
# 
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class AreaThreed < Base
    # Creates a 3d area chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "3d area"      
    end
  end
end