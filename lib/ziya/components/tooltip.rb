# -----------------------------------------------------------------------------
# Describes the look and feel for a chart annotation. An annotation must be
# added using the Chart#add( :series) call using the hash definition ie
#
# chart.add( :series, "fred", [ { :value => 10, :tooltip => "Hi there !"} ] )
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies the label for the chart element actual value. This can be setup to 
  # be fixed or as a tooltip
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=tooltip
  # for additional documentation, examples and futher detail.          
  class Tooltip < Base  
    has_attribute :font, :bold, :size, :color, :alpha, 
                  :background_color, :background_alpha, 
                  :duration,
                  :shadow, :bevel, :glow, :blur        
  end
end