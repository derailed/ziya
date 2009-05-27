require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class State < Base
    has_attribute :data, :name, :hover, :url, :target
  end
end