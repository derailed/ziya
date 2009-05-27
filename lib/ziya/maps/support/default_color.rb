require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class DefaultColor < Base
    has_attribute :color, :opacity            
  end
end