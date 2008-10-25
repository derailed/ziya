# -----------------------------------------------------------------------------
# Describes the look and feel for a chart annotation. An annotation must be
# added using the Chart#add( :series) call using the hash definition ie
#
# chart.add( :series, "fred", [ { :value => 10, :note => "Hi there !"} ] )
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
module Ziya::Components
  # Specifies an annotation look and feel on a chart. 
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=chart_note
  # for additional documentation, examples and futher detail.          
  class ChartNote < Base  
    has_attribute :type, :x, :y, :offset_x, :offset_y,
                  :font, :bold, :size, :color, :alpha, 
                  :background_color, :background_alpha, :shadow, :bevel, :glow, :blur        
  end
end