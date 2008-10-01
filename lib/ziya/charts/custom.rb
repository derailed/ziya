# -----------------------------------------------------------------------------
# Generates necessary xml for an custom chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ziya/charts/base'

module Ziya::Charts
  class Custom < Base
    # Creates an area chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.        
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = ""      
    end
  end
end