=== ZiYa
    by Fernand Galiana
    git://github.com/derailed/ziya.git

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
  2.1.0 - Refactor some of the underlying ziya code
          - Beef up test suite
          - changed component tree
        - Added geographical maps support
        - Changed the default ziyafy to install charts only by default
          Run ziyafy --help for the various options
        - Changed add( :composites, ... ) call to take in a hash of hash instead of id/url pair.
          So the correct call is now of the form chart.add( :composites, :id => { :url => ... } )
          You can now add extra attributes that will be passed to the generated image component.
  2.1.4 - Added support for xm/swf 5.0.8
        - Removed dependency on logging gem version
  2.1.5 - Added ability to enhance draw and link components in subsequent stylesheets. The old
          behavior was to simply override the whole component. Now you can keep enhancing these components
          in higher level stylesheets.
          
== DESCRIPTION:

ZiYa allows you to easily create interactive charts, gauges and maps for your web applications. ZiYa leverages
flash which offload heavy server side processing to the client. At the root ZiYa allows you to easily generate an
XML files that will be downloaded to the client for rendering. Using this gem, you will be able to easily create great
looking charts for your application. You will also be able to use the charts, gauges and maps has a navigation scheme 
by embedding various link in the graphical components thus bringing to the table an ideal scheme for reporting and dashboard
like applications. Your manager will love you for it !!

	Blog Site     : http://ziya.liquidrail.com
	Documentation : http://ziya.liquidrail.com/docs
	Forum         : http://groups.google.com/group/ziya-plugin
	Repositories  : git://github.com/derailed/ziya.git

== FEATURES:

*  Supports a wide variety of chart/gauge types, sure to fit your needs.
*  Geographical maps. Maps can be drillable and refreshable
*  Relieves your server load by generating the actual chart on the client side.
*  Provides for cascading like css-styles for your charts using YAML files.
*  Themes support. You can change the appearance and behavior of any charts by introducing new themes

== REQUIREMENTS:

  ZiYa depends on the following gems
  
  * logging
  * color
  
  ZiYa comes pre-bundled with the following packages:
  * XML/SWF charts Version 5.07 (http://www.maani.us/xml_charts/index.php)
  * XML/SWF gauges Version 1.6  (http://www.maani.us/gauge/index.php)
  * DIY Maps                    (http://backspace.com/mapapp/)
  
  XML/SWF
    * XML/SWF charts are free of charge unless you need to use special features such
      as embedded links and printing. 
       
      The package cost $45 per domain, including localhost and is well worth the investment. 
      A similar fee applies to the gauge framework.
  
  DIY Map
    * This package is free for use in non-commercial applications. For commercial applications,
    there is a $20.00 license per domain. I have chosen this package over others, as it supports
    the interaction and configuration I was looking for, it seems stable and packs lots of features
    for a reasonable price.
  
== INSTALL:
  
  NOTE: You will need to add github as a gem source and thus will need gem version 1.3 or later
  
  > gem sources -a http://gems.github.com
  
  > sudo gem install derailed-ziya
  
  cd to your application directory and issue the following command
  
  > ziyafy --charts
  
  This will copy the necessary themes and flash files to run ZiYa in your application 
  public/charts directory. You can install maps and gauges components as well. Type in
  
  > ziyafy --help 
    
  To see all available options.
              
== SYNOPSIS:
  
  This gem version requires a client update to flash 9.0 and possibly you will
  need to get a new license from XML/SWF >= 5.0, if you want to use
  advanced features suck as links and live updates.
  
== Creating a ZiYa chart in a Rails 2.3 application
  
  1 - Create a ziya.rb file under config/initializers

      ziya.rb:

        # Pull in the ZiYa gem framework
        gem 'derailed-ziya', '= 2.1.0'
        require 'ziya'

        # Initializes the ZiYa Framework
        Ziya.initialize( 
          :logger     => RAILS_DEFAULT_LOGGER,
          :themes_dir => File.join( File.dirname(__FILE__), %w[.. .. public charts themes]) 
        )

       This will initialize the gem. You can log the output to stdout using the ZiYa bundled logger
       or specify a file ie File.join( File.dirname(__FILE__), %w[.. log ziya.log]. If you choose to use the 
       ZiYa logger, you can specify the :log_level option to either :warn :info :debug or :error.
       You will need to specify your themes directory typically located under public/charts/themes or any location
       you'll like to choose.
      
   3 - Create a chart controller
   
      blee_controller.rb:
   
       class BleeController < ApplicationController
        # Load ZiYa necessary helpers
        helper Ziya::HtmlHelpers::Charts
        helper Ziya::YamlHelpers::Charts
       
        # Callback from the flash movie to get the chart's data
        def load_chart
          # Create a bar chart with 2 series composed of 3 data points each.
          # Chart will be rendered using the default look and feel
          chart = Ziya::Charts::Bar.new
          chart.add( :axis_category_text, %w[2006 2007 2008] )
          chart.add( :series, "Dogs", [10,20,30] )
          chart.add( :series, "Cats", [5,15,25] )
          respond_to do |fmt|
            fmt.xml { render :xml => chart.to_xml }
          end
       end
  
   4 - Create a view
   
      blee/index.html.erb:
   
        # Defines the necessary tag to embed a flash movie in your html page.
        # This will callback to your controller to fetch the necessary xml.
        <%= ziya_chart load_chart_url -%>
   
   5 - Create a named route
   
      config/routes.rb:
      
       map.load_chart '/blee/load_chart', :controller => 'blee', :action => 'load_chart'
   
== Styling a chart

=== Basic Theme
   
   1 - Create a directory fred in public/charts/themes
   2 - Create a file called column_chart.yml under the fred directory
   2 - Edit column_chart.yml and add the following lines mind the yaml 2 space indentation!
   
   <%= chart :column %>
     <%=comp :axis_category %>
       color: ff0000
       
   3 - In fred_controller add the following directive to the chart to associate your new theme with the chart
   
   chart.add( :theme, 'fred' )
   
   4 - reload the page and you should now see the red x axis label
   
=== Cascading themes
   
   To override the default column chart theme, you may now create an instance theme. 
   
   1 - Create fred.yml in public/chart/themes/fred
   
   2 - Edit fred.yml as follows

   <%= chart :column %>
     <%=comp :axis_category %>
       color: 00ff00
   
   3 - Edit your controller to indicate the instance theme name
   
   chart = Ziya::Charts.Column.new( nil, 'fred' )
   
   4 - Reload the page - The x axis category labels should now be green.
   
   NOTE: There are lots of setup example for themes in the ziya-galeria app at 
   git://github.com/derailed/ziya-galeria.git. 
   The themes component follows the xml/swf xml settings for configuration which 
   are documented here http://www.maani.us/xml_charts/index.php?menu=Reference
   
=== Using theme helpers

   Just like rails view template helpers, ZiYa support helpers for theme stylesheets.
   In order to use a helper for your chart you will need to use the following steps:
   
   1 - Create a ziya directory under app/helpers
   2 - Create a file called fred_helper.rb
   3 - Edit fred_helper.rb and add the following lines
   
   module Ziya::FredHelper
     def random_color
       %w[ffaa00 aaff00 aabbff][rand(3)]
     end
   end
   
   4 - Edit you theme stylesheet to call the helper method
   
   In fred.yml
   
   <%= chart :column %>
     <%=comp :axis_category %>
       color: <%= random_color %>
          
   5 - Edit you config/initializer/ziya.rb and add the following line
   
      # Initializes the ZiYa Framework
      Ziya.initialize( :logger => RAILS_DEFAULT_LOGGER,
        :helpers_dir    => File.join( File.dirname(__FILE__), %w[.. .. app helpers ziya] ), # <-- New line !!
        :themes_dir     => File.join( File.dirname(__FILE__), %w[.. .. public charts themes]) 
      )
   
   6 - Restart your app server
   7 - Reload the page serveral time and watch the x axis label color change
   
== Creating a gauge for a rails application

  You will need to modify the ziya initializer and add the following directive
  
    Ziya.initialize( 
      :logger      => RAILS_DEFAULT_LOGGER,
      :designs_dir => File.join( File.dirname(__FILE__), %w[.. .. public gauges designs] ), # => Add this !!
      :themes_dir  => File.join( File.dirname(__FILE__), %w[.. .. public charts themes]) )  
                 
  * fred_controller.rb
  
    class FredController < ApplicationController
      def load_gauge
        gauge = Ziya::Gauges::Base.new( LICENCE_KEY, 'my_gauge' )
         respond_to do |fmt|
          fmt.xml => { render :xml => gauge.to_xml }
         end
      end        
    end
    
   * fred/index.html.erb
   
   <%= ziya_gauge load_gauge_url -%>

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