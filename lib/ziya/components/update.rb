# -----------------------------------------------------------------------------
# Sets up handler for refresh the chart content. The refresh xml can only refresh
# parts of the chart that have changed.
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Updates the chart at intervals, without reloading the web page. This makes it possible
  # to display charts with live data, change the chart's look over time for emphasis, or
  # create a slideshow from different charts.
  #
  # <tt></tt>:
  #
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=live_update
  # for additional documentation, examples and futher detail.  
  class Update < Base  
    has_attribute :url, :delay, :timeout, :retry, :mode, :span
  end
end