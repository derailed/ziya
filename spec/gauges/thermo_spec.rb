require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Gauges::Thermo do  
  describe "#initialize" do    
    before( :each ) do
      @gauge = Ziya::Gauges::Thermo.new( "test_license", "override" ) 
    end
    
    it "should create a gauge with the correct license" do
      @gauge.license.should == "test_license"
    end    
    
    it "should create a gauge with the correct id" do
      @gauge.design_id.should == "override"
    end        
  end    

  describe "#to_xml" do  
    it "should produce the correct xml for the std gauge" do
      buff  = Ziya::Gauges::Thermo.new( "test_license" ).to_xml
      buff.scan( /<license/ ).size.should == 1
      buff.scan( /<circle/ ).size.should  == 6  
      buff.scan( /<line/ ).size.should    == 13      
      buff.scan( /<rect/ ).size.should    == 4
      buff.scan( /x1=\"(.*?\d+)\"/ ).should == [["30"], ["30"], ["30"], ["30"], ["30"], ["30"], ["30"], ["80"], ["80"], ["80"], ["80"], ["80"], ["80"]]
      buff.scan( /y1=\"(.*?\d+)\"/ ).should == [["155.0"], ["138.0"], ["121.0"], ["104.0"], ["87.0"], ["70.0"], ["53.0"], ["153"], ["133"], ["113"], ["93"], ["73"], ["53"]]
      buff.scan( /x2=\"(.*?\d+)\"/ ).should == [["38"], ["38"], ["38"], ["38"], ["38"], ["38"], ["38"], ["88"], ["88"], ["88"], ["88"], ["88"], ["88"]]
      buff.scan( /y2=\"(.*?\d+)\"/ ).should == [["155.0"], ["138.0"], ["121.0"], ["104.0"], ["87.0"], ["70.0"], ["53.0"], ["153"], ["133"], ["113"], ["93"], ["73"], ["53"]]
      buff.scan( /x=\"(.*?\d+)\"/ ).should  == [["-130"], ["40"], ["60"], ["60"], ["60"], ["55"], ["20"], ["20"], ["85"], ["60"], ["44"], ["44"], ["10"], ["10"], ["10"], ["10"], ["10"], ["10"], ["10"], ["88"], ["88"], ["88"], ["88"], ["88"], ["88"], ["999"]]
      # buff.scan( /y=\"(.*?\d+)\"/ ).should  == [["290"], ["40"], ["210"], ["210"], ["210"], ["210"], ["20"], ["25"], ["25"], ["10"], ["153"], ["52"], ["152"], ["147.0"], ["130.0"], ["113.0"], ["96.0"], ["79.0"], ["62.0"], ["45.0"], ["145"], ["125"], ["105"], ["85"], ["65"], ["45"], ["999"]]
    end 
    
    it "user can override due point" do
      gauge = Ziya::Gauges::Thermo.new( "test_license" )
      gauge.set_preferences( :due_point => 100 )
      buff  = gauge.to_xml
      buff.scan( /end_scale=\"(.*?\d+)\"/ ).should == [["80"]]
    end 
    
    it "user can override thermo color" do
      gauge = Ziya::Gauges::Thermo.new( "test_license" )
      gauge.set_preferences( :gauge_color => "00FF00" )
      buff  = gauge.to_xml
      buff.scan( /end_scale=\"(.*?\d+)\"/ ).should == [["20"]]
      buff.scan( /color=\"(\w+)\"/ ).uniq.should   == [["ffffff"], ["00FF00"], ["ffff00"], ["cccccc"], ["aaaaaa"], ["880000"]]
    end 
    
  end  
end
