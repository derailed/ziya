# -----------------------------------------------------------------------------
# Geocode representations
#
# Author: Fernand
# -----------------------------------------------------------------------------
module Ziya::Maps
  class Geocode
    attr_reader :long, :lat
  
    def initialize( lat, long )
      @lat, @long = lat, long
    end
  
    def to_s
      "#{lat},#{long}"
    end
  end
end