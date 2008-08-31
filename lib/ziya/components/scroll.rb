# -----------------------------------------------------------------------------
# Embeds a scroller in a given chart
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
require 'ziya/components/base'

module Ziya::Components
  # Specifies the ability to scroll a chart by setting single or double sliders
  # on the chart.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=scroll
  # for additional documentation, examples and futher detail.
  #  
  class Scroll < Base  
    has_attribute :x, :y, :width, :height, :alpha,
                  :transition, :delay, :duration,
                  :url_button_1_idle, :url_button_1_over, :url_button_1_press,
                  :url_button_2_idle, :url_button_2_over, :url_button_2_press,
                  :url_slider_body, :url_slider_handle_1, :url_slider_handle_2,
                  :button_length, :slider_handle_length, :gap, :button_speed, 
                  :buttons_together, :start, :span, :drag, :reverse_handle,
                  :scroll_detail, :stop_detail,
                  :timeout, :retry         
  end
end