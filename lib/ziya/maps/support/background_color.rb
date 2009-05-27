require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class BackgroundColor < Base
    has_attribute :color, :opacity            
  end
end