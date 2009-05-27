require 'ziya/maps/support/base'

module Ziya::Maps::Support
  class Region < Base
    has_attribute :data, :name, :loc
  end
end