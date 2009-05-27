require 'ziya/maps/base'

module Ziya::Maps
  class Australia < Ziya::Maps::Base
    def initialize( id=nil )
      super( :australia, id )
    end
  end
end