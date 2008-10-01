# -----------------------------------------------------------------------------
# Generates necessary xml for an image pie chart 
#
# Author: Fernand
# -----------------------------------------------------------------------------
require 'ziya/charts/base'

module Ziya::Charts
  class ImagePie < Base
    # Creates an area chart
    # <tt>:license</tt>::  the XML/SWF charts license
    # <tt>:chart_id</tt>:: the name of the chart style sheet.        
    def initialize( license=nil, chart_id=nil )
      super( license, chart_id )
      @type = "image pie"      
    end
  end
end