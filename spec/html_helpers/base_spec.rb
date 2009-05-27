require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::HtmlHelpers::Base do 
  
  include Ziya::HtmlHelpers::Base
  
  it "should generate the correct mime" do
    mime.should == "application/x-shockwave-flash"
  end
  
  it "should generate the correct plugin url" do
    plugin_url.should == "http://www.macromedia.com/go/getflashplayer"
  end
  
  describe "should generate the correct wmode" do    
    before( :each ) do
      @opts = { :bgcolor => '#ffffff' } 
    end
    
    it "should set up the correct wmode when a background color is specified" do
      setup_wmode( @opts )
      @opts[:wmode].should == "opaque"
    end
    
    it "should not override wmode if specified" do
      @opts[:wmode] = "test"
      setup_wmode( @opts )
      @opts[:wmode].should == "test"
    end
    
    it "should generate the correct defaults if no color is specified" do
      @opts.delete( :bgcolor )
      setup_wmode( @opts )
      @opts[:wmode].should   == "transparent"
      @opts[:bgcolor].should == "#FFFFFF"
    end    
  end
  
  it "should set up the flash movie size correctly" do
    opts = { :size => "400x300" }
    setup_movie_size( opts )
    opts[:size].should   be_nil
    opts[:width].should  == "400"
    opts[:height].should == "300"
  end
  
  it "should escape a url correctly" do
    escape_url( "http://fred?arg1=1&amp;arg2=2&amp;test=hello world" ).should == "http%3A%2F%2Ffred%3Farg1%3D1%26arg2%3D2%26test%3Dhello+world"
  end
end