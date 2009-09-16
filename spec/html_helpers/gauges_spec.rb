require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::HtmlHelpers::Gauges do   
  include Ziya::HtmlHelpers::Gauges
      
  it "should set up the correct default options" do
    opts = default_gauge_options
    opts[:swf_path].should == "/gauges"
  end
  
  it "should generate the correct flash embed tag" do
    ziya_gauge( "/test/test_me", :swf_path => '/blee' ).should == "      <object codebase=\"http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,45,0\" classid=\"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000\" id=\"ziya_gauge\" height=\"200\" width=\"200\">\n        <param name=\"scale\" value=\"noscale\"/>\n        <param name=\"align\" value=\"middle\"/>            \n        <param name=\"bgcolor\" value=\"#FFFFFF\"/>\n        <param name=\"wmode\" value=\"transparent\"/>                                  \n        <param name=\"movie\" value=\"/blee/gauge.swf?xml_source=/test/test_me&amp;timeout=30&amp;retry=2\"/>\n        <param name=\"menu\" value=\"true\"/>\n        <param name=\"allowFullScreen\" value=\"true\"/>\n        <param name=\"allowScriptAccess\" value=\"sameDomain\"/>            \n        <param name=\"quality\" value=\"high\"/>\n        <param name=\"play\" value=\"true\"/>                        \n        <param name=\"devicefont\" value=\"false\"/>\n        <embed scale=\"noscale\"\n          allowfullscreen=\"true\" \n          allowscriptaccess=\"sameDomain\" \n          bgcolor=\"#FFFFFF\" \n          devicefont=\"false\" \n          src=\"/blee/gauge.swf?xml_source=/test/test_me&amp;timeout=30&amp;retry=2\" \n          menu=\"true\" \n          name=\"ziya_gauge\" \n          play=\"true\" \n          pluginspage=\"http://www.macromedia.com/go/getflashplayer\" \n          quality=\"high\" \n          salign=\"\" \n          src=\"/blee/gauge.swf?xml_source=/test/test_me&amp;timeout=30&amp;retry=2\" \n          type=\"application/x-shockwave-flash\" \n          wmode=\"transparent\" \n          salign=\"\" \n          height=\"200\" \n          width=\"200\">\n     </object>        \n"
  end
  
end
  