# -----------------------------------------------------------------------------
# Draw base class for all draw components
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  class DrawBase < Base  # :nodoc:
    has_attribute :shadow, :bevel, :glow, :blur
  end
end