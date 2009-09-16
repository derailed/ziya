# -----------------------------------------------------------------------------
# Sets up a drawing area on the chart to draw text, rect, circles...
#
# Author:: Fernand Galiana
# -----------------------------------------------------------------------------
require 'ziya/html_helpers/charts'

module Ziya::Charts::Support
  # Sets up a drawing area on the chart to draw text, rect, circles...
  #
  # Holds any number of elements to draw. A draw element can be a circle, image (JPEG or SWF),
  # line, rectangle, or text. Use draw "image" to include SWF flash file with animation,
  # roll-over buttons, sounds, scripts, etc.
  #
  # <tt></tt>:
  #
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.
  #  
  class Draw < Base  
    include Ziya::HtmlHelpers::Charts
    
    has_attribute :components
                         
    # -------------------------------------------------------------------------
    # Override merge attributes enhance component definitions vs override
    def merge( parent_attributes, override=false )
      comps = send( :components ) || []
      comps = comps + parent_attributes.send( :components ) if parent_attributes.send( :components )
      send( "components=", comps )      
    end
                         
    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    def flatten( xml, composite_urls=nil )
      if components or composite_urls
        xml.draw do 
          components.each { |comp| comp.flatten( xml ) } if components
          gen_composites( xml, composite_urls ) if composite_urls
        end
      end
    end
    
    # -------------------------------------------------------------------------
    # Generates Draw component for composite charts
    def gen_composites( xml, composite_urls ) 
      composite_urls.keys.sort{ |a,b| a.to_s <=> b.to_s }.each do |chart_id|
        # composite descriptor can either be a string for the comp url or a pair for the swf lib_path and url
        raise "You must specify a hash of options" unless composite_urls[chart_id].is_a? Hash
        opts = composite_urls[chart_id].clone
        url  = opts.delete( :url )
        raise "Unable to find composite chart url" unless url
        path = opts.delete(:path ) || chart_path 
        opts[:url] = gen_composite_path( path, url, chart_id )
        
        self.class.module_eval <<-XML
         xml.image( #{opts_as_string( opts )} )
        XML
        
        # xml.image( opts )
      end
    end
    
    # -------------------------------------------------------------------------
    # Turns options hash into string representation
    def opts_as_string( opts )
      buff = []
      opts.keys.sort{ |a,b| a.to_s <=> b.to_s }.each do |k|
        value = opts[k]
        buff << sprintf( ":%s => '%s'", k, value.to_s ) if value
      end    
      buff.join( "," )
    end

  end
end