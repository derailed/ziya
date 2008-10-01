# -----------------------------------------------------------------------------
# Sets up various preferences available on a given chart type
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Sets the preferences for some chart types. Each chart type has different preferences,
  # or no preferences at all.
  #
  # <tt></tt>:
  #
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=chart_pref
  # for additional documentation, examples and futher detail.
  #  
  class ChartPref < Base  
    has_attribute :line_thickness, :point_shape, :point_size, :fill_shape, :connect, :tip,
                  :type, :bull_color, :bear_color,
                  :drag, :min_x, :min_y, :max_x, :max_y,
                  :trend_thickness, :trend_alpha, :line_alpha, :rotation_x,
                  :rotation_y, :grid, :select, :empty_center
  end
end