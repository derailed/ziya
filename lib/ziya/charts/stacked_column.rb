# -----------------------------------------------------------------------------
# Generates necessary xml for a stacked column chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class StackedColumn < Base
    # Creates a stacked column chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.              
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "stacked column"      
    end
  end
end