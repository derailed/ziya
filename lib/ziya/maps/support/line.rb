require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class Line < Base
    has_attribute :name, :start, :stop, :stroke, :data
  end
end