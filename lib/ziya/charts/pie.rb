# -----------------------------------------------------------------------------
# Generates necessary xml for pie chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Pie < Base
    # Creates a pie chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "pie"      
    end
  end
end