require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::HtmlHelpers::Maps do   
  include Ziya::HtmlHelpers::Maps
      
  it "should set up the correct default options" do
    opts = default_map_options
    opts[:swf_path].should == "/maps/map_library"
  end
  
  it "should generate the correct controller callback url" do
    gen_sw_path( "/maps", 'world.swf', "/maps/load_test_map" ).should == "/maps/world.swf?data_file=%2Fmaps%2Fload_test_map"
  end
  
  it "should generate the correct flash embed tag" do
    ziya_map( "/test/test_me", :swf_path => '/blee' ).should == "    <object codebase=\"\" classid=\"clsid:d27cdb6e-ae6d-11cf-96b8-444553540000\" id=\"ziya_map\" height=\"300\" width=\"400\">\n      <param name=\"align\"             value=\"top\"/>            \n      <param name=\"Flashvars\"         value=\"lcId=ziya_map\"/>      \n      <param name=\"bgcolor\"           value=\"#FFFFFF\"/>\n      <param name=\"wmode\"             value=\"opaque\"/>                                  \n      <param name=\"movie\"             value=\"/blee/world.swf?data_file=%2Ftest%2Ftest_me\"/>\n      <param name=\"quality\"           value=\"high\"/>\n      <embed scale=\"noscale\" \n        flashvars         = \"lcId=ziya_map\" \n        bgcolor           = \"#FFFFFF\" \n        src               = \"/blee/world.swf?data_file=%2Ftest%2Ftest_me\" \n        name              = \"ziya_map\" \n        pluginspage       = \"http://www.macromedia.com/go/getflashplayer\" \n        quality           = \"high\" \n        type              = \"application/x-shockwave-flash\" \n        wmode             = \"opaque\" \n        align             = \"top\" \n        height            = \"300\" \n        width             = \"400\"/>            \n     </object>\n"
  end
  
end
  