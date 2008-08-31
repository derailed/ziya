module Ziya::Gauge2Helper
  def colorize
    "ff00ff"
  end
  
  # creates a red circle start at coords x,y radius r
  def make_circle( x, y, radius )
    circle = Ziya::Gauges::Support::Circle.new( 
      :x          => x, 
      :y          => y, 
      :radius     => radius, 
      :start      => 0, 
      :end        => 360, 
      :fill_color => "ff0000" )
    circle.to_comp_yaml( :circle_2, 2 )
  end
end