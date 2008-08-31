# -----------------------------------------------------------------------------
# Generates necessary xml for 3D column chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class ColumnThreed < Base
    # Creates a 3D Column chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "3d column"      
    end
  end
end