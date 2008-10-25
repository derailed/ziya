# Generates necessary html flash tag to support ZiYa
#
# TODO -- Rewrite to use content tag block instead...
#
# Author: Fernand Galiana
require 'cgi'
require 'erb'

module Ziya
  module Helper    
    
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
       
    # generates necessary object and embed tags to display a flash movie on various 
    # browsers using javascript
    def ziya_chart_js( url, chart_options={} )
      options = { :width          => "400",
                  :height         => "300",
                  :bgcolor        => "000000",
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
      }.merge!(chart_options)

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
              'codebase'         , 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0',
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
    
    # generates necessary html tags to display a gauge.  
    def ziya_gauge( url, gauge_options={} )
      options = { :width          => "200",
                  :height         => "200",
                  :align          => "middle",
                  :scale          => "noscale",
                  :salign         => "",
                  :class          => "",        
                  :id             => "ziya_gauge",
                  :swf_path       => gauge_path,
                  :use_cache      => false,
                  :timeout        => false,
                  :retry          => 2,
                  :use_stage      => false
                }.merge!(gauge_options)
                      
      generate_old_style_flash_tag( url, gauges_swf, options )
    end
        
    # generates neccessary html tags to display a chart.
    def ziya_chart( url, chart_options = {} )
      options = { :width          => "400",
                  :height         => "300",
                  :tag_type       => "embed",
                  :align          => "l",
                  :salign         => "tl",
                  :scale          => "noscale",
                  :class          => "",   
                  :id             => "ziya_chart",
                  :swf_path       => chart_path,
                  :use_cache      => false,
                  :timeout        => nil,
                  :use_stage      => false
                }.merge!(chart_options)
    
      flash_vars = url ? charts_swf : charts_swf_base
      generate_flash_tag( url, flash_vars, "charts.swf", options )
    end   
        
    # flash chart library path
    def gen_composite_path( swf_chart_dir, url, chart_id=null )
      buff = ""
      if url
        buff = composite_url % [swf_chart_dir, swf_chart_dir, escape_url( url )] 
      else
        buff = composite_base_url % [swf_chart_dir, swf_chart_dir]
      end
      buff << "&chart_id=#{chart_id}" if chart_id
      buff
    end
    
    # =========================================================================
    # private                               

      # Const accessors...
      def mime()               "application/x-shockwave-flash"; end
      def composite_base_url() "%s/charts.swf?library_path=%s/charts_library" end        
      def composite_url()      "#{composite_base_url}&xml_source=%s" end
      def charts_swf_base()    "library_path=%s/charts_library"; end      
      def charts_swf()         "#{charts_swf_base}&xml_source=%s"; end      
      def plugin_url()         "http://www.macromedia.com/go/getflashplayer"; end
      def gauges_swf()         "%s/gauge.swf?xml_source=%s"; end              
      def gauge_path()         "/gauges"; end
      def chart_path()         "/charts"; end       
      def class_id()           "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" end
      def codebase()           "http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0"; end

      # generates swf path
      def gen_swf_path( path_directive, swf_dir, url )
        path_directive % [swf_dir, escape_url( url )]        
      end

      def generate_old_style_flash_tag( url, swf_path, options )
        # Setup options for opaque mode
        setup_wmode( options )      
        
        # setup width and height
        setup_movie_size( options )
        
        color_param  = tag( 'param', {:name => 'bgcolor', :value => options[:bgcolor]}, true )
        color_param += tag( 'param', {:name  => "wmode", :value => options[:wmode]}, true )
      
        xml_swf_path = swf_path % [options[:swf_path], url]
        xml_swf_path << "&timestamp=#{Time.now.to_i}" if options[:use_cache] == true
        xml_swf_path << "&timeout=#{options[:timeout]}&retry=#{options[:retry]}" if options[:timeout] == true
        xml_swf_path << "&stage_width=#{options[:width]}&stage_height=#{options[:height]}" if options[:use_stage] == true
        tags = <<-TAGS
          <object codebase="#{codebase}" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="#{options[:id]}" height="#{options[:height]}" width="#{options[:width]}">
            <param name="scale" value="noscale">
            <param name="align" value="#{options[:align]}">            
            <param name="bgcolor" value="#{options[:bgcolor]}">
            <param name="wmode" value="#{options[:wmode]}">                                  
            <param name="movie" value="#{xml_swf_path}">
            <param name="menu" value="true">
            <param name="allowFullScreen" value="true">
            <param name="allowScriptAccess" value="sameDomain">            
            <param name="quality" value="high">
            <param name="play" value="true">                        
            <param name="devicefont" value="false">
            <embed scale="noscale"
              allowfullscreen="true" 
              allowscriptaccess="sameDomain" 
              bgcolor="#{options[:bgcolor]}" 
              devicefont="false" 
              src="#{xml_swf_path}" 
              menu="true" 
              name="#{options[:id]}" 
              play="true" 
              pluginspage="http://www.macromedia.com/go/getflashplayer" 
              quality="high" 
              salign="#{options[:salign]}" 
              src="#{xml_swf_path}" 
              type="application/x-shockwave-flash" 
              wmode="#{options[:wmode]}" 
              salign="#{options[:salign]}" 
              height="#{options[:height]}" 
              width="#{options[:width]}">
         </object>        
        TAGS
      end
      
      # generated the object and embed tag necessary for the flash movie
      def generate_flash_tag( url, swf_path, swf_file, options )
        # Setup options for opaque mode
        setup_wmode( options )      
        
        # setup width and height
        setup_movie_size( options )
        
        color_param  = tag( 'param', {:name => 'bgcolor', :value => options[:bgcolor]}, true )
        color_param += tag( 'param', {:name  => "wmode", :value => options[:wmode]}, true )

        xml_swf_path = gen_swf_path( swf_path, options[:swf_path], url )
        xml_swf_path << "&timestamp=#{Time.now.to_i}" if options[:cache] == false
        xml_swf_path << "&timeout=#{options[:timeout]}" if options[:timeout]
        xml_swf_path << "&stage_width=#{options[:width]}&stage_height=#{options[:height]}" if options[:use_stage] == true 
        
        tags = <<-TAGS
        <object codebase="#{codebase}" classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" id="#{options[:id]}" height="#{options[:height]}" width="#{options[:width]}">
          <param name="scale"             value="noscale">
          <param name="salign"            value="#{options[:salign]}">            
          <param name="bgcolor"           value="#{options[:bgcolor]}">
          <param name="wmode"             value="#{options[:wmode]}">                                  
          <param name="movie"             value="#{options[:swf_path]}/#{swf_file}">
          <param name="Flashvars"         value="#{xml_swf_path}&chart_id=#{options[:id]}">
          <param name="menu"              value="true">
          <param name="allowFullScreen"   value="true">
          <param name="allowScriptAccess" value="sameDomain">            
          <param name="quality"           value="high">
          <param name="play"              value="true">                        
          <param name="devicefont"        value="false">
            <embed scale="noscale" 
              allowfullscreen   = "true" 
              allowscriptaccess = "sameDomain" 
              bgcolor           = "#{options[:bgcolor]}" 
              devicefont        = "false" 
              flashvars         = "#{xml_swf_path}&chart_id=#{options[:id]}" 
              menu              = "true" 
              name              = "#{options[:id]}" 
              play              = "true" 
              pluginspage       = "http://www.macromedia.com/go/getflashplayer" 
              quality           = "high" 
              salign            = "#{options[:salign]}" 
              src               = "#{options[:swf_path]}/#{swf_file}" 
              type              = "application/x-shockwave-flash" 
              wmode             = "#{options[:wmode]}" 
              align             = "#{options[:align]}" 
              height            = "#{options[:height]}" 
              width             = "#{options[:width]}"/>            
         </object>        
        TAGS
      end
              
      # escape url    
      def escape_url( url )
        url ? CGI.escape( url.gsub( /&amp;/, '&' ) ) : url
      end
    
      # setup up wmode
      # Set the wmode to opaque if a bgcolor is specified. If not set to
      # transparent mode unless user overrides it    
      def setup_wmode( options )
        if options[:bgcolor]
          options[:wmode] = "opaque" unless options[:wmode]
        else
          options[:wmode]   = "transparent" unless options[:wmode]
          options[:bgcolor] = "#FFFFFF"
        end
      end

      # Check args for size option in the format wXy (Submitted by Sam Livingston-Gray)                                  
      def setup_movie_size( options )
        if options[:size] =~ /(\d+)x(\d+)/
          options[:width]  = $1
          options[:height] = $2
          options.delete :size
        end
      end
    
      # All this stolen form rails to make Ziya work with other fmks....    
      def tag(name, options = nil, open = false, escape = true)
       "<#{name}#{tag_options(options, escape) if options}" + (open ? ">" : " />")
      end    
      
      def escape_once(html)
        html.to_s.gsub(/[\"><]|&(?!([a-zA-Z]+|(#\d+));)/) { |special| escape_chars[special] }
      end
      
      def tag_options(options, escape = true)
        unless !options or options.empty?
          attrs = []
          if escape
            options.each do |key, value|
              next unless value
              key = key.to_s
              value = escape_once(value)
              attrs << %(#{key}="#{value}")
            end
          else
            attrs = options.map { |key, value| %(#{key}="#{value}") }
          end
          " #{attrs.sort * ' '}" unless attrs.empty?
        end
      end
      
      def content_tag(name, content_or_options_with_block = nil, options = nil, escape = true, &block)
        if block_given?
          options = content_or_options_with_block if content_or_options_with_block.is_a?(Hash)
          content = capture_block(&block)
          content_tag = content_tag_string(name, content, options, escape)
          block_is_within_action_view?(block) ? concat(content_tag, block.binding) : content_tag
        else
          content = content_or_options_with_block
          content_tag_string(name, content, options, escape)
        end
      end
      
      def capture_block( *args, &block )
          block.call(*args)
      end
      
      def content_tag_string(name, content, options, escape = true)
        tag_options = tag_options(options, escape) if options
        "<#{name}#{tag_options}>#{content}</#{name}>"
      end

      def block_is_within_action_view?(block)
        eval("defined? _erbout", block.binding)
      end  
      
      def escape_chars 
        { '&' => '&amp;', '"' => '&quot;', '>' => '&gt;', '<' => '&lt;' }
      end          
  end
end
