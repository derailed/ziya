require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class Point < Base
    has_attribute :name, :loc, :url, :hover, :opacity, :size, 
      :data, :color, :src, :target
  end
end