module Ziya::HtmlHelpers::Maps
  include Ziya::HtmlHelpers::Base
  
  def maps_swf_base()    "/maps"; end      
  def maps_swf()         "#{maps_swf_base}?data_file=%s"; end      
  
  # default options
  def default_map_options
    { 
      :width          => "400",
      :height         => "300",
      :map_type       => :world,
      :id             => "ziya_map",
      :code_base      => "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,0,0",
      :align          => "top",
      :quality        => "high",
      :wmode          => "opaque",   
      :class_id       => "clsid:d27cdb6e-ae6d-11cf-96b8-444553540000",
      :swf_path       => "/maps/map_library",
      :use_cache      => false
    }
  end

  # generates swf path
  def gen_sw_path( path, swf_file, url )
    path_directive = "#{path}/%s?data_file=%s"
    path_directive % [swf_file, escape_url( url )]
  end
    
  # generates necessary tags for map support
  def ziya_map( url, map_options={} )
    options = default_map_options.merge( map_options )    
    _ziya_map( url, "#{options[:map_type]}.swf", options )
  end
    
  # generates actual html tags
  def _ziya_map( url, swf_file, options )    
    # Setup options for opaque mode
    setup_wmode( options )      
  
    # setup width and height
    setup_movie_size( options )
  
    color_param  = ziya_tag( 'param', {:name => 'bgcolor', :value => options[:bgcolor]}, true )
    color_param += ziya_tag( 'param', {:name  => "wmode", :value => options[:wmode]}, true )

    xml_swf_path = gen_sw_path( options[:swf_path], swf_file, url )
    xml_swf_path << "&amp;timestamp=#{Time.now.to_i}" if options[:cache]
        
    tags = <<-TAGS
    <object codebase="#{options[:codebase]}" classid="#{options[:class_id]}" id="#{options[:id]}" height="#{options[:height]}" width="#{options[:width]}">
      <param name="align"             value="#{options[:align]}"/>            
      <param name="Flashvars"         value="lcId=#{options[:id]}"/>      
      <param name="bgcolor"           value="#{options[:bgcolor]}"/>
      <param name="wmode"             value="#{options[:wmode]}"/>                                  
      <param name="movie"             value="#{xml_swf_path}"/>
      <param name="quality"           value="#{options[:quality]}"/>
      <embed scale="noscale" 
        flashvars         = "lcId=#{options[:id]}" 
        bgcolor           = "#{options[:bgcolor]}" 
        src               = "#{xml_swf_path}" 
        name              = "#{options[:id]}" 
        pluginspage       = "#{plugin_url}" 
        quality           = "high" 
        type              = "#{mime}" 
        wmode             = "#{options[:wmode]}" 
        align             = "#{options[:align]}" 
        height            = "#{options[:height]}" 
        width             = "#{options[:width]}"/>            
     </object>
    TAGS
        
  end
end