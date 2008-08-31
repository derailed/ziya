require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Gauges::Base do
  describe "#initialize" do
    before( :each ) do
      @gauge = Ziya::Gauges::Base.new( "test_license", "test" ) 
    end
    
    it "should create a gauge with the correct license" do
      @gauge.license.should == "test_license"
    end    
    
    it "should create a gauge with the correct id" do
      @gauge.design_id.should == "test"
    end        
  end    

  describe "#to_xml" do
    it "should produce the correct xml for a basic gauge" do
      gauge = Ziya::Gauges::Base.new( "aaa", "gauge_1" )
      buff  = gauge.to_xml
      buff.scan( /<license/ ).size.should == 1
      buff.scan( /<circle/ ).size.should  == 2   
      buff.scan( /<line/ ).size.should    == 11        
      buff.scan( /x1=\"(.*?\d+)\"/ ).should == [["200"], ["204"], ["209"], ["213"], ["217"], ["220"], ["223"], ["225"], ["226"], ["227"], ["200"]]
      buff.scan( /y1=\"(.*?\d+)\"/ ).should == [["48"], ["48"], ["49"], ["51"], ["54"], ["57"], ["61"], ["65"], ["70"], ["75"], ["45"]]
      buff.scan( /x2=\"(.*?\d+)\"/ ).should == [["200"], ["206"], ["212"], ["218"], ["223"], ["228"], ["232"], ["234"], ["236"], ["237"], ["200"]]
      buff.scan( /y2=\"(.*?\d+)\"/ ).should == [["38"], ["38"], ["40"], ["42"], ["46"], ["51"], ["56"], ["62"], ["68"], ["75"], ["52"]]
    end 

    it "should produce the correct xml for a gauge with no design override" do
      gauge = Ziya::Gauges::Base.new( "aaa", "title" )
      buff  = gauge.to_xml
      buff.scan( /<license/ ).size.should == 1
      buff.scan( /<text/ ).size.should  == 1
      buff.scan( /x=\"(.*?\d+)\"/ ).should == [["-15"]]
      buff.scan( /y=\"(.*?\d+)\"/ ).should == [["300"]]
    end 
      
    it "should produce the correct xml for a gauge with design override" do
      gauge = Ziya::Gauges::Base.new( "aaa", "circle" )
      buff  = gauge.to_xml
      buff.scan( /<license/ ).size.should  == 1
      buff.scan( /<text/ ).size.should     == 1   
      buff.scan( /<circle/ ).size.should   == 1
      buff.scan( /x=\"(.*?\d+)\"/ ).should == [["999"],["-15"]]
      buff.scan( /y=\"(.*?\d+)\"/ ).should == [["999"], ["300"]]
    end 
    
    it "should throw an exception when yaml is hosed" do
      gauge = Ziya::Gauges::Base.new( "aaa", "crapping_out" )
      lambda { gauge.to_xml }.should raise_error
    end     
  end
    
  describe "helpers" do
    gauge = Ziya::Gauges::Base.new( "aaa", "gauge_2" )
    buff  = gauge.to_xml
    buff.scan( /<license/ ).size.should          == 1
    buff.scan( /<circle/ ).size.should           == 2         
    buff.scan( /x=\"(.*?\d+)\"/ ).should         == [ ["200"], ["10"] ]
    buff.scan( /y=\"(.*?\d+)\"/ ).should         == [ ["75"], ["10"] ]
    buff.scan( /start=\"(.*?\d+)\"/ ).should     == [ ["0"] ]
    buff.scan( /end=\"(.*?\d+)\"/ ).should       == [ ["360"] ]
    buff.scan( /fill_color=\"(\w{6})\"/ ).should ==  [ ["ff00ff"], ["ff0000"] ]
  end   
  
  describe "helpers" do
    gauge = Ziya::Gauges::Base.new( "aaa", "gauge_2" )
    buff  = gauge.to_xml
    buff.scan( /<license/ ).size.should          == 1
    buff.scan( /<circle/ ).size.should           == 2         
    buff.scan( /x=\"(.*?\d+)\"/ ).should         == [ ["200"], ["10"] ]
    buff.scan( /y=\"(.*?\d+)\"/ ).should         == [ ["75"], ["10"] ]
    buff.scan( /start=\"(.*?\d+)\"/ ).should     == [ ["0"] ]
    buff.scan( /end=\"(.*?\d+)\"/ ).should       == [ ["360"] ]
    buff.scan( /fill_color=\"(\w{6})\"/ ).should ==  [ ["ff00ff"], ["ff0000"] ]
  end   
  
  describe "refresh" do
    gauge = Ziya::Gauges::Base.new( "aaa", "gauge_1" )
    gauge.set_preferences( :url => "/blee/fred" )
    buff  = gauge.to_xml
    buff.scan( /<license/ ).size.should          == 1
    buff.scan( /<update/ ).size.should           == 1        
    buff.scan( /url=\"(\/\w+\/\w+)\"/ ).should         == [ ["/blee/fred"] ]
    buff.scan( /delay=\"(.*?\d+)\"/ ).should         == [ ["30"] ]
  end    
  
end
