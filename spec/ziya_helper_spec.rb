require File.expand_path(File.join(File.dirname(__FILE__), %w[spec_helper]))

describe Ziya::Helper do  
  before( :all ) do
    @url = "/fred/blee/duh"
  end

  describe "ziya_gauge" do    
    it "should generate the correct html with the default options" do
      ziya_gauge( @url ).should == "          <object codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" id=\"ziya_gauge\" height=\"200\" width=\"200\">\n            <param name=\"scale\" value=\"noscale\">\n            <param name=\"align\" value=\"middle\">            \n            <param name=\"bgcolor\" value=\"#FFFFFF\">\n            <param name=\"wmode\" value=\"transparent\">                                  \n            <param name=\"movie\" value=\"/gauges/gauge.swf?xml_source=/fred/blee/duh\">\n            <param name=\"menu\" value=\"true\">\n            <param name=\"allowFullScreen\" value=\"true\">\n            <param name=\"allowScriptAccess\" value=\"sameDomain\">            \n            <param name=\"quality\" value=\"high\">\n            <param name=\"play\" value=\"true\">                        \n            <param name=\"devicefont\" value=\"false\">\n            <embed scale=\"noscale\"\n              allowfullscreen=\"true\" \n              allowscriptaccess=\"sameDomain\" \n              bgcolor=\"#FFFFFF\" \n              devicefont=\"false\" \n              src=\"/gauges/gauge.swf?xml_source=/fred/blee/duh\" \n              menu=\"true\" \n              name=\"ziya_gauge\" \n              play=\"true\" \n              pluginspage=\"http://www.macromedia.com/go/getflashplayer\" \n              quality=\"high\" \n              salign=\"\" \n              src=\"/gauges/gauge.swf?xml_source=/fred/blee/duh\" \n              type=\"application/x-shockwave-flash\" \n              wmode=\"transparent\" \n              salign=\"\" \n              height=\"200\" \n              width=\"200\">\n         </object>        \n"
    end
    
    it "should set the wmode to opaque if bg_color is set" do
      html = ziya_gauge( @url, :bgcolor => "ffffff" )
      html.index (/name=\"wmode\" value=\"opaque\"/).should_not be_nil
      html.index (/wmode=\"opaque\"/).should_not be_nil      
    end
    
    it "should handle the size has widthxheight" do
      html = ziya_gauge( @url, :size => "100x200" )
      html.index (/width=\"100\"/).should_not be_nil
      html.index (/height=\"200\"/).should_not be_nil      
    end    
  end
  
  describe "ziya_chart" do
    it "should generate the correct embed tag with the default options" do
      ziya_chart( @url, :tag_type => "embed" ).should == "        <object codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" id=\"ziya_chart\" height=\"300\" width=\"400\">\n          <param name=\"scale\"             value=\"noscale\">\n          <param name=\"salign\"            value=\"tl\">            \n          <param name=\"bgcolor\"           value=\"#FFFFFF\">\n          <param name=\"wmode\"             value=\"transparent\">                                  \n          <param name=\"movie\"             value=\"/charts/charts.swf\">\n          <param name=\"Flashvars\"         value=\"library_path=/charts/charts_library&xml_source=%2Ffred%2Fblee%2Fduh&chart_id=ziya_chart\">\n          <param name=\"menu\"              value=\"true\">\n          <param name=\"allowFullScreen\"   value=\"true\">\n          <param name=\"allowScriptAccess\" value=\"sameDomain\">            \n          <param name=\"quality\"           value=\"high\">\n          <param name=\"play\"              value=\"true\">                        \n          <param name=\"devicefont\"        value=\"false\">\n            <embed scale=\"noscale\" \n              allowfullscreen   = \"true\" \n              allowscriptaccess = \"sameDomain\" \n              bgcolor           = \"#FFFFFF\" \n              devicefont        = \"false\" \n              flashvars         = \"library_path=/charts/charts_library&xml_source=%2Ffred%2Fblee%2Fduh&chart_id=ziya_chart\" \n              menu              = \"true\" \n              name              = \"ziya_chart\" \n              play              = \"true\" \n              pluginspage       = \"http://www.macromedia.com/go/getflashplayer\" \n              quality           = \"high\" \n              salign            = \"tl\" \n              src               = \"/charts/charts.swf\" \n              type              = \"application/x-shockwave-flash\" \n              wmode             = \"transparent\" \n              align             = \"l\" \n              height            = \"300\" \n              width             = \"400\"/>            \n         </object>        \n"
    end

    it "should generate the correct object tag with the default options" do
      ziya_chart( @url, :tag_type => "object" ).should == "        <object codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" id=\"ziya_chart\" height=\"300\" width=\"400\">\n          <param name=\"scale\"             value=\"noscale\">\n          <param name=\"salign\"            value=\"tl\">            \n          <param name=\"bgcolor\"           value=\"#FFFFFF\">\n          <param name=\"wmode\"             value=\"transparent\">                                  \n          <param name=\"movie\"             value=\"/charts/charts.swf\">\n          <param name=\"Flashvars\"         value=\"library_path=/charts/charts_library&xml_source=%2Ffred%2Fblee%2Fduh&chart_id=ziya_chart\">\n          <param name=\"menu\"              value=\"true\">\n          <param name=\"allowFullScreen\"   value=\"true\">\n          <param name=\"allowScriptAccess\" value=\"sameDomain\">            \n          <param name=\"quality\"           value=\"high\">\n          <param name=\"play\"              value=\"true\">                        \n          <param name=\"devicefont\"        value=\"false\">\n            <embed scale=\"noscale\" \n              allowfullscreen   = \"true\" \n              allowscriptaccess = \"sameDomain\" \n              bgcolor           = \"#FFFFFF\" \n              devicefont        = \"false\" \n              flashvars         = \"library_path=/charts/charts_library&xml_source=%2Ffred%2Fblee%2Fduh&chart_id=ziya_chart\" \n              menu              = \"true\" \n              name              = \"ziya_chart\" \n              play              = \"true\" \n              pluginspage       = \"http://www.macromedia.com/go/getflashplayer\" \n              quality           = \"high\" \n              salign            = \"tl\" \n              src               = \"/charts/charts.swf\" \n              type              = \"application/x-shockwave-flash\" \n              wmode             = \"transparent\" \n              align             = \"l\" \n              height            = \"300\" \n              width             = \"400\"/>            \n         </object>        \n"
    end

    it "should generate the correct js tag" do
      ziya_javascript_include_tag.should == "        <script language=\"javascript\" type=\"text/javascript\">\n          AC_FL_RunContent = 0;\n          DetectFlashVer = 0;\n        </script>\n        <script src=\"/charts/AC_RunActiveContent.js\" language=\"javascript\"></script>\n        <script language=\"javascript\" type=\"text/javascript\">\n          var requiredMajorVersion = 9;\n          var requiredMinorVersion = 0;\n          var requiredRevision = 45;\n        </script>\n"
    end
     
    it "should generate the correct js based chart tag" do
      ziya_chart_js( @url ).should == "        <script language=\"javascript\" type=\"text/javascript\">\n        if (AC_FL_RunContent == 0 || DetectFlashVer == 0) {\n          alert( \"This page requires AC_RunActiveContent.js.\" );\n        } \n        else {\n          var hasRightVersion = DetectFlashVer(requiredMajorVersion, requiredMinorVersion, requiredRevision);\n          if( hasRightVersion ) { \n            AC_FL_RunContent(\n              'codebase'         , 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0',\n              'width'            , '400',\n              'height'           , '300',\n              'scale'            , 'noscale',\n              'salign'           , 'tl',\n              'bgcolor'          , '000000',\n              'wmode'            , 'opaque',\n              'movie'            , '/charts/charts',\n              'src'              , '/charts/charts',\n              'FlashVars'        , 'library_path=/charts/charts_library&xml_source=%2Ffred%2Fblee%2Fduh&chart_id=ziya_chart', \n              'id'               , 'ziya_chart',\n              'name'             , 'ziya_chart',\n              'menu'             , 'true',\n              'allowFullScreen'  , 'true',\n              'allowScriptAccess','sameDomain',\n              'quality'          , 'high',\n              'align'            , 'l',\n              'pluginspage'      , 'http://www.macromedia.com/go/getflashplayer',\n              'play'             , 'true',\n              'devicefont'       , 'false'\n            ); \n          } \n          else { \n            var alternateContent = 'This content requires the Adobe Flash Player. '\n            + '<u><a href=http://www.macromedia.com/go/getflash/>Get Flash</a></u>.';\n            document.write(alternateContent); \n          }\n        }\n        </script>\n"
    end
       
    it "should set the wmode to opaque if bg_color is set" do
      html = ziya_chart( @url, :bgcolor => "ffffff" )      
      # html.index (/name=\"wmode\" value=\"opaque\"/).should_not be_nil
      # html.index (/'wmode'\s+,\s'opaque'/).should_not be_nil      
      html.index( /wmode\s+=\s\"opaque\"/ ).should_not be_nil
    end
    
    it "should handle the size has widthxheight" do
      html = ziya_chart( @url, :size => "100x200" )
      html.index( /width=\"100\"/ ).should_not be_nil      
      html.index( /height=\"200\"/ ).should_not be_nil            
      # html.index (/'width'\s+,\s'100'/).should_not be_nil
      # html.index (/'height'\s+,\s'200'/).should_not be_nil      
    end    
  end
  
  describe "escape_url" do
    it "should escape a plain url correctly" do
      escape_url( "/fred/blee/duh" ).should == "%2Ffred%2Fblee%2Fduh"
    end
    
    it "should escape a url with args correctly" do
      escape_url( "/fred?blee=hello world&bobo=10" ).should == "%2Ffred%3Fblee%3Dhello+world%26bobo%3D10"
    end
  end
  
  describe "setup_mode" do
    before( :each ) do
      @options = { :bgcolor => "#000000" }
    end
    
    it "should set the wmode to opaque if a color is given" do
      setup_wmode( @options )  
      @options[:wmode].should == "opaque"
    end
    
    it "should set the wmode to transparent and color to white if a color is not given" do
      @options.delete(:bgcolor )
      setup_wmode( @options )  
      @options[:wmode].should   == "transparent"
      @options[:bgcolor].should == "#FFFFFF"      
    end
  
    it "should not set the wmode is user specified it" do
      @options.delete(:bgcolor )
      @options[:wmode] = 'transparent'
      setup_wmode( @options )  
      @options[:wmode].should   == "transparent"
      @options[:bgcolor].should == "#FFFFFF"      
    end    
  end
  
  describe "content_tag" do
    it "should output an html tag correctly" do
      content_tag( :div, content_tag( :h1, "Hello" ) ).should == "<div><h1>Hello</h1></div>"
    end
    
    it "should use leverage block to generate a tag" do
      content_tag( :div, :class => "fred", :id => "duh" ) do
        content_tag( :h2, "World" )
      end.should == "<div class=\"fred\" id=\"duh\"><h2>World</h2></div>"
    end
  end
  
  describe "tag_options" do
    it "should correctly escape tag options" do
      tag_options( {:blee => "<blee>", :fred => 10 }, true ).should == " blee=\"&lt;blee&gt;\" fred=\"10\""
    end
    
    it "should leave tag options unescaped" do
      tag_options( {:blee => "<blee>", :fred => 10 }, false ).should == " blee=\"<blee>\" fred=\"10\""
    end
  end
   
end