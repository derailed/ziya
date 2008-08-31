# -----------------------------------------------------------------------------
# Abstract class representing a radial based gauge
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Gauges
  class Radial < Base
    
    # =========================================================================
    protected

    # converts degrees to radiants    
  	def deg2rad( degrees )
  	  degrees * Math::PI / 180
  	end

  end
end