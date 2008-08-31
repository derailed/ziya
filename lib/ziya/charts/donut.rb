# -----------------------------------------------------------------------------
# Generates necessary xml for donut chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ziya/charts/base'

module Ziya::Charts
  class Donut < Base
    # Creates a donut chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.        
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "donut"      
    end
  end
end