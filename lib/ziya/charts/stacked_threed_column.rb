# -----------------------------------------------------------------------------
# Generates necessary xml for a stacked 3d column chart
# 
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class StackedThreedColumn < Base
    # Creates a stacked 3d column chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "stacked 3d column"      
    end
  end
end