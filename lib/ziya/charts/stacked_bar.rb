# -----------------------------------------------------------------------------
# Generates necessary xml for a stacked bar chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class StackedBar < Base
    # Creates a stacked bar chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil)
      super( license, chart_id )
      @type = "stacked bar"      
    end
  end
end