# -----------------------------------------------------------------------------
# Generates necessary xml for a Column chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Column < Base
    # Creates a column chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "column"      
    end
  end
end