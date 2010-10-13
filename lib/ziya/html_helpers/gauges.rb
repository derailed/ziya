# Generates necessary html flash tag to support ZiYa
#
# TODO -- Rewrite to use content tag block instead...
#
# Author: Fernand Galiana

module Ziya::HtmlHelpers::Gauges
  include Ziya::HtmlHelpers::Base
          
  # generates necessary html tags to display a gauge.  
  def ziya_gauge( url, gauge_options={} )
    options = default_gauge_options.merge( gauge_options )                    
    _ziya_gauge( url, gauges_swf, options )
  end
            
  # =========================================================================
  # private                               

  # Const accessors...
  def gauges_swf()         "%s/gauge.swf?xml_source=%s"; end              
  def gauge_path()         "/gauges"; end
  def class_id()           "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" end
  def codebase()           "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0"; end

  def default_gauge_options
    { :width          => "200",
      :height         => "200",
      :align          => "middle",
      :scale          => "noscale",
      :script_access  => "sameDomain",
      :salign         => "",
      :class          => "",   
      :class_id       => "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000",    
      :id             => "ziya_gauge",
      :swf_path       => gauge_path,
      :use_cache      => false,
      :timeout        => 30,
      :retry          => 2,
      :use_stage      => false }    
  end

  def _ziya_gauge( url, swf_path, options )
    # Setup options for opaque mode
    setup_wmode( options )      
    
    # setup width and height
    setup_movie_size( options )
    
    color_param  = ziya_tag( 'param', {:name => 'bgcolor', :value => options[:bgcolor]}, true )
    color_param += ziya_tag( 'param', {:name  => "wmode", :value => options[:wmode]}, true )
  
    xml_swf_path = swf_path % [options[:swf_path], url]
    xml_swf_path << "&amp;timestamp=#{Time.now.to_i}" if options[:use_cache] == true
    xml_swf_path << "&amp;timeout=#{options[:timeout]}&amp;retry=#{options[:retry]}" if options[:timeout]
    xml_swf_path << "&amp;stage_width=#{options[:width]}&amp;stage_height=#{options[:height]}" if options[:use_stage] == true
    tags = <<-TAGS
      <object codebase="#{codebase}" classid="#{options[:class_id]}" id="#{options[:id]}" height="#{options[:height]}" width="#{options[:width]}">
        <param name="scale" value="noscale"/>
        <param name="align" value="#{options[:align]}"/>            
        <param name="bgcolor" value="#{options[:bgcolor]}"/>
        <param name="wmode" value="#{options[:wmode]}"/>                                  
        <param name="movie" value="#{xml_swf_path}"/>
        <param name="menu" value="true"/>
        <param name="allowFullScreen" value="true"/>
        <param name="allowScriptAccess" value="#{options[:script_access]}"/>            
        <param name="quality" value="high"/>
        <param name="play" value="true"/>                        
        <param name="devicefont" value="false"/>
        <embed scale="noscale"
          allowfullscreen="true" 
          allowscriptaccess="#{options[:script_access]}" 
          bgcolor="#{options[:bgcolor]}" 
          devicefont="false" 
          src="#{xml_swf_path}" 
          menu="true" 
          name="#{options[:id]}" 
          play="true" 
          pluginspage="#{plugin_url}" 
          quality="high" 
          salign="#{options[:salign]}" 
          src="#{xml_swf_path}" 
          type="#{mime}" 
          wmode="#{options[:wmode]}" 
          salign="#{options[:salign]}" 
          height="#{options[:height]}" 
          width="#{options[:width]}">
     </object>        
    TAGS
  end
end
