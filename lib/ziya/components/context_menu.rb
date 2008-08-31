# -----------------------------------------------------------------------------
# Defines an area on a chart. Typically used to embed links and buttons
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/components/base'

module Ziya::Components
  # Refines the default context menu by adding or removing default options
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=context_menu
  # for additional documentation, examples and futher detail.
  class ContextMenu < Base  
    has_attribute :about, :print, :full_screen, :quality, :jpeg_url
  end
end