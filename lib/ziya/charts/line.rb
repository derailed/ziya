# -----------------------------------------------------------------------------
# Generates necessary xml for a line chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Line < Base
    # Creates a line chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "line"      
    end
  end
end