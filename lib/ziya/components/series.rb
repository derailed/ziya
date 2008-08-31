# -----------------------------------------------------------------------------
# Refines series attributes on a chart
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/components/base'

module Ziya::Components
  # Specifies the gap betwen cols/bars and gap between series for column and bar
  # charts only.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=series
  # for additional documentation, examples and futher detail.
  class Series < Base  
    has_attribute :bar_gap, :set_gap, :transfer
  end
end