# -----------------------------------------------------------------------------
# Generates necessary xml for scatter chart 
# 
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Scatter < Base
    # Creates a scatter chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "scatter"      
    end
  end
end         
