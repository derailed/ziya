require 'ziya/yaml_helpers/base'
require 'ziya/html_helpers/charts'

module Ziya
  module YamlHelpers
    module Charts
      include Ziya::YamlHelpers::Base, Ziya::HtmlHelpers::Charts

      # Defines various helpers to assist in writing ZiYa yaml stylesheets.
  
      # generates a swf chart path from the given url. Used as helper to embed a chart
      # within a chart
      # ==== Example
      #   <%= chart_url( chart_1_path, "fred" ) %>
      #
      #  => /charts/charts.swf?library_path=/charts/charts_library&xml_source=http://fred/load_chart_1.xml&chart_id=fred
      def chart_url( url, swf_chart_dir="/charts", id=nil )
        gen_composite_path( swf_chart_dir, url, id )
      end
  
      # generates a component yaml class declaration
      # ==== Example
      #  <%= component :axis_category %>
      #  => axis_category: --- !ruby/object:Ziya::Charts::Support::AxisCategory
      def component( component_name )
        "#{component_name}: #{clazz component_name, 'Charts::Support' }"
      end
      alias :comp :component
  
      # generates a drawing yaml class declaration
      # ==== Example
      #  <%=drawing :rect %>
      #  => --- !ruby/object:Ziya::Charts::Support::Rect
      def drawing( class_name )
        clazz( class_name, 'Charts::Support' )
      end
      alias_method :filter_type, :drawing
      alias_method :area       , :drawing
  
      # generates a yaml chart declaration
      # ==== Example
      #  <%= chart :bar %>
      #  => --- !ruby/object:Ziya::Charts::Bar
      def chart( class_name )
        "--- #{clazz( class_name, :Charts )}" 
      end
    end
  end
end