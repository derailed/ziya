# -----------------------------------------------------------------------------
# Generates necessary xml for parallel 3D column chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class ParallelThreedColumn < Base
    # Creates a parallel column 3D chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "parallel 3d column"      
    end
  end
end