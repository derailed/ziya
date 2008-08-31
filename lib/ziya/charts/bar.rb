# -----------------------------------------------------------------------------
# Generates necessary xml for a Bar chart
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Bar < Base
    # Creates a bar chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "bar"
    end
  end
end