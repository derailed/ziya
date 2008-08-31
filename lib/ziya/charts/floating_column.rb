# -----------------------------------------------------------------------------
# Generates necessary xml for a floating column chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class FloatingColumn < Base
    # Creates a floating column chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "floating column"
    end
  end
end