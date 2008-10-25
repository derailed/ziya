=== ZiYa
    by Fernand Galiana
    ziya.rubyforge.org ( deprecated )
    git://github.com/derailed/ziya.git ( preferred )

== RELEASES

  2.0.0 - Added support for XML/SWF 5.02
  2.0.1 - Additional support for 5.02 + Added donut chart from 5.03
  2.0.2 - Changed logging required to 0.9.X - Update to xml/swf 5.0.4
  2.0.3 - README file update - Thanks to Paul James !
  2.0.4 - Fixed missing encoding on composite urls - published gem on github
  2.0.5 - Fixed merb app support issue
  2.0.6 - Updates to support xml/swf 5.0.5
  2.0.7 - Updates to support xm/swf 5.0.7
          - added parameters for the ziya_js helpers ( Tx Brian ! )
          - added draw button support
          - added chart_note to annotate a chart
          - added tooltip chart support
  2.0.8 - Patches to xml/swf/5.0.7 - scroller handle fixe + Stoppped_Scolling js callback 
          - added support for flash_to_javascript callbacks
          - added support ids in composite charts
          - various bug fixes 
  
== DESCRIPTION:

ZiYa allows you to easily display graphs in your ruby based applications by leveraging
SWF Charts (http://www.maani.us/xml_charts/index.php) and SWF gauges (http://www.maani.us/gauge/index.php). 
This gem bundles version 5.03 and 1.6 of these flash libraries. Incorporating flash graphs or gauge in your app 
relieves the server by allowing for delegating graph rendering to the client side. Using this gem, you will
be able to easily create great looking charts for your application. You will also be able
to use the charts or gauges has a navigation scheme by embedding various link in the graphical components
thus bring to the table an ideal scheme for reporting and dashboard like applications. Your
managers will love you for it !!

	Checkout the demo: http://ziya.liquidrail.com
	Video            : http://www.youtube.com/watch?v=axIMmMHdXzo ( Out of date but you'll get the basics... )
	Documentation    : http://ziya.liquidrail.com/docs
	Forum            : http://groups.google.com/group/ziya-plugin
	Repositories     : http://rubyforge.org/projects/ziya ( deprecated )
	                   git://github.com/derailed/ziya.git ( preferred )


== FEATURES:

*  Supports a wide variety of chart/gauge types, sure to fit your needs.
*  Relieves your server load by generating the actual chart on the client side.
*  Allows you to style your charts just like you would an html page using css styles
   philosophy. Each chart can be associated with a YAML file that allows you to specify
   preferences based on SWF Charts properties. Chart stylesheets reside under 
   public/charts/themes. Each chart type may have an associated YAML file. You can either 
   inherit the default styles or define your own by specifying an id when you create your graph. 
   The styles will cascade thru your graph class hierarchy and override default preferences as you
   would in a stylesheet.
   NOTE: XML/SWF charts are free of charge unless you need to use special features such
   as embedded links and printing. 
   The package cost $45 per domain, including localhost and is well worth the investment. 
   A similar fee applies to the gauge framework.
*  We are leveraging ERB within the YAML file to provide access to the chart/gauge state. State
   can be passed in via the options hash when the graph/gauge is generated.
   You can also define your own methods in helpers/ziya/xxx_helper. You can access these
   helper methods in your style file just like you would in a rails template.
*  Theme support. You can change the appearance and behavior of any charts by introducing
   new themes under the public/charts/themes directory.

== REQUIREMENTS:

  ZiYa depends on the logging gem version >= 0.9.0

== INSTALL:
  
  On rubyforge
  
  sudo gem install ziya ( deprecated )
  
  or github
  
  sudo gem install derailed-ziya ( preferred )
  
  cd to your application directory and issue the following command
  
  > ziyafy
  
  This will copy the necessary themes and flash files to run ZiYa in your application 
  public/charts directory.
      
== SYNOPSIS:
  
  This new gem version requires a client update to flash 9.0 and possibly you will
  need to get a new license from XML/SWF >= 5.0 ( $45.0 for your domain ), if you want to use
  advanced features suck as links and live updates. Also some api's have changed. 
  I will try to push a new sample application and more docs in the next few weeks. 
  So make sure you try this out first in a non production environment and report
  bugs or side effects. I'll do my best to keep up with the demand. If anyone would like to give
  me a hand with a tutorial app or improving the docs, I am all hears...
  
  When using within a rails application you will need to create a ziya.rb file in your
  config/initializers directory ( Rails 2.0 ). 
  
  NOTE: For rails version < 2.0, you can add the following code in your config/enviroment.rb directly.
  
  ziya.rb:
  
    # Pull in the ZiYa gem framework
    gem "ziya", ">= 2.0.0"
    require 'ziya'

    # Initializes the ZiYa Framework
    Ziya.initialize( 
      :logger      => RAILS_DEFAULT_LOGGER,
      :helpers_dir => File.join( File.dirname(__FILE__), %w[.. .. app helpers ziya] ),
      :themes_dir  => File.join( File.dirname(__FILE__), %w[.. .. public charts themes]) 
    )
  
   This will initialize the gem. You can log the output to stdout using the ZiYa bundled logger
   or specify a file ie File.join( File.dirname(__FILE__), %w[.. log ziya.log]. If you choose to use the 
   ZiYa logger, you can specify the :log_level option to either :warn :info :debug or :error.
   You will need to indicate your themes directory typically located under public/charts/themes or any location
   you'll choose. Lastly you can specify a custom helper directory :helpers_dir, so you can use helper methods 
   within your ZiYa stylesheets.
   
   NOTE: You must create the app/helpers/ziya and public/chart/themes directory in your application.
   
== Creating a chart
   
   * blee_controller.rb
   
     class BleeController < ApplicationController
       helper Ziya::Helper
       
       # Callback from the flash movie to get the chart's data
       def load_chart
         # Create a bar chart with 2 series composed of 3 data points each.
         # Chart will be rendered using the default look and feel
         chart = Ziya::Charts::Bar.new
         chart.add( :axis_category_text, %w[2006 2007 2008] )
         chart.add( :series, "Dogs", [10,20,30] )
         chart.add( :series, "Cats", [5,15,25] )
         respond_to do |fmt|
          fmt.xml => { render :xml => chart.to_xml }
       end
     end
     
   * blee/index.html.erb
   
     Defines the necessary tag to embed a flash movie in your html page.
     This will callback to your controller to fetch the necessary xml.
     <%= ziya_chart load_chart_url, :size => "300x200" -%>
   
   * config/routes.rb
   
     Creates a named route for the chart.
     map.load_chart '/blee/load_chart', :controller => 'blee', :action => 'load_chart'
   
== Creating a gauge

  You will need to modify the ziya initializer and add the following directive
  
    Ziya.initialize( 
      :logger      => RAILS_DEFAULT_LOGGER,
      :helpers_dir => File.join( File.dirname(__FILE__), %w[.. .. app helpers ziya] ),
      :designs_dir => File.join( File.dirname(__FILE__), %w[.. .. public gauges designs] ), # => Add this !!
      :themes_dir  => File.join( File.dirname(__FILE__), %w[.. .. public charts themes]) )  
                 
  * fred_controller.rb
  
    class FredController < ApplicationController
      def load_gauge
        gauge = Ziya::Gauges::Base.new( @license_key, 'my_gauge' )
         respond_to do |fmt|
          fmt.xml => { render :xml => gauge.to_xml }
         end
      end        
    end
    
   * fred/index.html.erb
   
   <%= ziya_gauge load_gauge_url, :size => "300x200" -%>

   * config/routes.rb
   
   # Creates a named route for the chart.
   map.load_gauge '/fred/load_gauge', :controller => 'fred', :action => 'load_gauge'
  
  * public/gauges/designs/my_gauge.yml

  In the design file you will leverage the components defined in the Ziya::Gauges::Support
  package to create your gauge desgins. You gauges can be animated using rotate, scale and 
  move operations. In this example we will create a volume control that will rotate to the
  desired position. In real life you will fetch the volume level from your models to
  set the desired position. Take a look at the ZiYa sample application for the various 
  possibilities. You can think of a gauge as a portable canvas element where you can draw
  you own designs using the various components provided ZiYa components ( No need to worry about
  various browsers' canvas support )
  
   <%= gauge :base %>  
      # specifies the number of ticks to draw in a circular fashion
      <%= dial :radial_ticks, :volume %>
          x:              100
          y:               75
          radius:          35
          length:           4
          start_angle:    235
          end_angle:      485
          ticks:           10
          thickness:        2
          color:       000000
      # rotates the volume to the desired position.
      <%= dial :rotate, :volume_setting %>
          x:               100
          y:                75
          start:           300
          span:            160
          step:              5
          skake_span:       20
          shadow_alpha:     20
          shadow_x_offset:   3
          shadow_y_offset:   3
          <%= dials %>
            <%= dial :circle, :circle_1 %>
                x:             100
                y:              75
                radius:         30
                fill_color: 777777
                line_thickness: 5
                line_alpha:     75        
            <%= dial :circle, :circle_2 %>
                x:          100
                y:           55
                radius:       5
                fill_alpha:  80
  
== LICENSE:

(The MIT License)

Copyright (c) 2008 FIXME (different license?)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
