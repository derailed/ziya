# -----------------------------------------------------------------------------
# Draws some text on a chart
#
# Author:: Fernand Galiana
# Date::   Dec 15th, 2006
# -----------------------------------------------------------------------------
module Ziya::Charts::Support
  # Text component to draw text on the chart. Must be set up within the draw
  # component.
  # See http://www.maani.us/xml_charts/index.php?menu=Reference&submenu=draw
  # for additional documentation, examples and futher detail.            
  class Text < Base  
    has_attribute :layer, :transition, :delay, :duration, :x, :y, :width,
                  :height, :h_align, :v_align, :rotation, :font, :bold, :size,
                  :color, :alpha, :shadow, :bevel, :glow, :blur, :text

    # -------------------------------------------------------------------------
    # Dump has_attribute into xml element
    def flatten( xml )
      opts = options.clone
      text = opts.delete( :text )
      xml.text( opts ) { |x| x.text!( text.to_s ) }
    end                  
  end
end