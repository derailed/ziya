# Generates necessary html flash tag to support ZiYa
#
# TODO -- Rewrite to use content tag block instead...
#
# Author: Fernand Galiana

module Ziya::HtmlHelpers::Charts
  include Ziya::HtmlHelpers::Base
    
  # generates a javascript tag to include the js script to create object and
  # embed tags
  def ziya_javascript_include_tag( opts={} )
    options = { :swf_path   => chart_path,
                :major_vers => 9,
                :minor_vers => 0,
                :req_vers   => 45 }.merge!( opts )
    
    js = <<-JS
      <script language="javascript" type="text/javascript">
        AC_FL_RunContent = 0;
        DetectFlashVer = 0;
      </script>
      <script src="#{options[:swf_path]}/AC_RunActiveContent.js" language="javascript"></script>
      <script language="javascript" type="text/javascript">
        var requiredMajorVersion = #{options[:major_vers]};
        var requiredMinorVersion = #{options[:minor_vers]};
        var requiredRevision = #{options[:req_vers]};
      </script>
     JS
  end
       
  def default_chart_options
    { 
      :width          => "400",
      :height         => "300",
      :bgcolor        => "ffffff",
      :wmode          => "opaque",
      :menu           => true,
      :full_screen    => true,
      :align          => "l",
      :salign         => "tl",
      :scale          => "noscale",
      :use_cache      => false,
      :timeout        => nil,
      :retry          => 2,
      :use_stage      => false,                  
      :id             => "ziya_chart",
      :swf_path       => chart_path,
      :asset_url      => chart_path
    }
  end
  
  # generates necessary object and embed tags to display a flash movie on various 
  # browsers using javascript
  def ziya_chart_js( url, chart_options={} )
    options = default_chart_options.merge( chart_options )

    # Setup options for opaque mode
    setup_wmode( options )      
    
    # setup width and height
    setup_movie_size( options )
    
    flash_vars   = url ? charts_swf : charts_swf_base
    xml_swf_path = flash_vars % [options[:swf_path], escape_url(url)]
    xml_swf_path << "&chart_id=#{options[:id]}"
    xml_swf_path << "&timestamp=#{Time.now.to_i}" if options[:cache] == false
    xml_swf_path << "&timeout=#{options[:timeout]}&retry=#{options[:retry]}" if options[:timeout]
    xml_swf_path << "&stage_width=#{options[:width]}&stage_height=#{options[:height]}" if options[:use_stage] == true 
    
    js = <<-JS
      <script language="javascript" type="text/javascript">
      if (AC_FL_RunContent == 0 || DetectFlashVer == 0) {
        alert( "This page requires AC_RunActiveContent.js." );
      } 
      else {
        var hasRightVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);
        if( hasRightVersion ) { 
          AC_FL_RunContent(
            'codebase'         , 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,45,2',
            'width'            , '#{options[:width]}',
            'height'           , '#{options[:height]}',
            'scale'            , '#{options[:scale]}',
            'salign'           , '#{options[:salign]}',
            'bgcolor'          , '#{options[:bgcolor]}',
            'wmode'            , '#{options[:wmode]}',
            'movie'            , '#{options[:swf_path]}/charts',
            'src'              , '#{options[:swf_path]}/charts',
            'FlashVars'        , '#{xml_swf_path}', 
            'id'               , '#{options[:id]}',
            'name'             , '#{options[:id]}',
            'menu'             , '#{options[:menu]}',
            'allowFullScreen'  , '#{options[:full_screen]}',
            'allowScriptAccess','sameDomain',
            'quality'          , 'high',
            'align'            , '#{options[:align]}',
            'pluginspage'      , 'http://www.macromedia.com/go/getflashplayer',
            'play'             , 'true',
            'devicefont'       , 'false'
          ); 
        } 
        else { 
          var alternateContent = 'This content requires the Adobe Flash Player. '
          + '<u><a href=http://www.macromedia.com/go/getflash/>Get Flash</a></u>.';
          document.write(alternateContent); 
        }
      }
      </script>
    JS
  end
            
  # generates neccessary html tags to display a chart.
  def ziya_chart( url, chart_options = {} )
    options = default_chart_options.merge( chart_options )
  
    flash_vars = url ? charts_swf : charts_swf_base
    buff       = _ziya_chart( url, flash_vars, "charts.swf", options )
         
    (respond_to? :raw) ? raw( buff ) : buff     
  end   
        
  # genereates composite chart urls
  def gen_composite_path( swf_chart_dir, url, chart_id=null )
    buff = ""
    if url
      buff = composite_url % [swf_chart_dir, swf_chart_dir, escape_url( url )] 
    else
      buff = composite_base_url % [swf_chart_dir, "/charts" ]
    end
    buff << "&chart_id=#{chart_id}" if chart_id
    buff
  end
    
  # =========================================================================
  # private                               

  # Const accessors...
  def composite_base_url() "%s/charts.swf?library_path=%s/charts_library" end        
  def composite_url()      "#{composite_base_url}&xml_source=%s" end
  def charts_swf_base()    "library_path=%s/charts_library"; end      
  def charts_swf()         "#{charts_swf_base}&xml_source=%s"; end      
  def chart_path()         "/charts"; end       
  def class_id()           "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" end
  def codebase()           "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=10,0,45,2"; end

  # generates swf path
  def gen_swf_path( path_directive, swf_dir, url )
    path_directive % [swf_dir, escape_url( url )]        
  end
      
  # generated the object and embed tag necessary for the flash movie
  def _ziya_chart( url, swf_path, swf_file, options )
    # Setup options for opaque mode
    setup_wmode( options )      
    
    # setup width and height
    setup_movie_size( options )
    
    color_param  = ziya_tag( 'param', {:name => 'bgcolor', :value => options[:bgcolor]}, true )
    color_param += ziya_tag( 'param', {:name  => "wmode", :value => options[:wmode]}, true )

    xml_swf_path = gen_swf_path( swf_path, options[:swf_path], url )
    xml_swf_path << "&amp;timestamp=#{Time.now.to_i}" if options[:cache] == false
    xml_swf_path << "&amp;timeout=#{options[:timeout]}" if options[:timeout]
    xml_swf_path << "&amp;stage_width=#{options[:width]}&amp;stage_height=#{options[:height]}" if options[:use_stage] == true 
    
    tags = <<-TAGS
    <object codebase="#{codebase}" classid="#{class_id}" id="#{options[:id]}" height="#{options[:height]}" width="#{options[:width]}">
      <param name="scale"             value="noscale"/>
      <param name="salign"            value="#{options[:salign]}"/>            
      <param name="bgcolor"           value="#{options[:bgcolor]}"/>
      <param name="wmode"             value="#{options[:wmode]}"/>                                  
      <param name="movie"             value="#{options[:asset_url]}/#{swf_file}"/>
      <param name="Flashvars"         value="#{xml_swf_path}&amp;chart_id=#{options[:id]}"/>
      <param name="menu"              value="true"/>
      <param name="allowFullScreen"   value="true"/>
      <param name="allowScriptAccess" value="#{options[:script_access]}"/>            
      <param name="quality"           value="high"/>
      <param name="play"              value="true"/>                        
      <param name="devicefont"        value="false"/>
        <embed scale="noscale" 
          allowfullscreen   = "true" 
          allowscriptaccess = "#{options[:script_access]}" 
          bgcolor           = "#{options[:bgcolor]}" 
          devicefont        = "false" 
          flashvars         = "#{xml_swf_path}&amp;chart_id=#{options[:id]}" 
          menu              = "true" 
          name              = "#{options[:id]}" 
          play              = "true" 
          pluginspage       = "#{plugin_url}" 
          quality           = "high" 
          salign            = "#{options[:salign]}" 
          src               = "#{options[:asset_url]}/#{swf_file}" 
          type              = "#{mime}" 
          wmode             = "#{options[:wmode]}" 
          align             = "#{options[:align]}" 
          height            = "#{options[:height]}" 
          width             = "#{options[:width]}"/>            
     </object>        
    TAGS
  end
end
