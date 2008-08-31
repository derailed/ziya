# -----------------------------------------------------------------------------
# Generates necessary xml for polar chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Polar < Base
    # Creates a polar chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.          
    def initialize( license=nil, chart_id=nil)
      super( license, chart_id )
      @type = "polar"      
    end
  end
end