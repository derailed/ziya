module Ziya::Maps
  class World < Ziya::Maps::Base
    def initialize( id=nil )
      super( :world, id )
    end
  end
end