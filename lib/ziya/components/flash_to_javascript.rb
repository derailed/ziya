# -----------------------------------------------------------------------------
# Provide for the toggling of js function callback. You can enable or disable
# some or all the automatic flash to js callbacks using this component
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/components/base'

module Ziya::Components
  # Toggles flash to js callbacks. 
  #
  # === Example
  # Add this component to your yaml stylesheet. Enables Loaded_Chart callback and disable
  # all other callbacks.
  #  <%= comp :flash_to_javascript %>
  #    Loaded_Chart:   true
  #    Render_Count:   false
  #    Scrolled_Chart: false
  # 
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=Flash_to_Javascript
  # for additional documentation, examples and further detail.
  class FlashToJavascript < Base  
    has_attribute :Loaded_Chart, :Render_Count, :Scrolled_Chart, :Stopped_Scrolling
  end
end