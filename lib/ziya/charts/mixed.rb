# -----------------------------------------------------------------------------
# Generates necessary xml for mixed chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Charts
  class Mixed < Base
    # Creates a mixed chart ie comosed of different chart types ie line + column
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.      
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = nil      
    end
  end
end