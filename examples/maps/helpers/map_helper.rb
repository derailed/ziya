# This illustrates the use of a ziya helper. Define view behavior in these
# classes. The location of the helpers is specified in the ziya initializer
# :helpers_dir configuration
module Ziya::MapHelper  
  # ---------------------------------------------------------------------------
  # Define custom outline color for use in the stylesheet
  def outline_color
    "f49329"
  end
  
  def random_color
    colors = %w[f49329 eced76 cc0000 0f67a1]
    colors[rand(3)]
  end
end