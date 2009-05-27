This directory indicates the location where you can specify the charts looks and feel.
You will need to create a new theme directory which contains the chart YAML stylesheets for
your various charts.

For example

public/charts/themes/blee
 - bar_chart.yml
 - polar_chart.yml
 
Then in your controller, indicate you want to choose the blee theme by using the following:

chart.add( :theme, "blee" )