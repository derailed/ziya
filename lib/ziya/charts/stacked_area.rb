# -----------------------------------------------------------------------------
# Generates necessary xml for stacked area chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class StackedArea < Base
    # Creates a stacked area chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil)
      super( license, chart_id )
      @type = "stacked area"      
    end
  end
end