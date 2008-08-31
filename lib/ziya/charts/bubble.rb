# -----------------------------------------------------------------------------
# Generates necessary xml for bubble chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ziya/charts/base'

module Ziya::Charts
  class Bubble < Base
    # Creates a bubble chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "bubble"      
    end
  end
end