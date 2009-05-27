require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class DefaultPoint < Base
    has_attribute :color, :size, :src, :opacity            
  end
end