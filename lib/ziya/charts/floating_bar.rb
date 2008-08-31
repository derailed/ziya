# -----------------------------------------------------------------------------
# Generates necessary xml for floating bar chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class FloatingBar < Base
    # Creates a floating bar chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "floating bar"      
    end
  end
end