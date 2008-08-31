# -----------------------------------------------------------------------------
# Generates necessary xml for candlestick chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class CandleStick < Base
    # Creates a candlestick chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "candlestick"      
    end
  end
end