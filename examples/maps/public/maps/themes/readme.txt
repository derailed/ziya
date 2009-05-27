This directory indicates the location where you can specify the maps looks and feel.
You will need to create a new theme directory which contains the map YAML stylesheets for
your various maps.

For example

public/charts/themes/cool_maps
 - us_map.yml
 - world_map.yml
 
Then in your controller, indicate you want to choose the 'cool_maps' theme by using the following:

map.add( :theme, "cool_maps" )