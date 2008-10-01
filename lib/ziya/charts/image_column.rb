# -----------------------------------------------------------------------------
# Generates necessary xml for an image column chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ziya/charts/base'

module Ziya::Charts
  class ImageColumn < Base
    # Creates an area chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.        
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "image column"      
    end
  end
end