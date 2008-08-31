require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::RadialTicks do
  before( :each ) do
    @comp = Ziya::Gauges::Support::RadialTicks.new
    @comp.x           = 1
    @comp.y           = 2
    @comp.radius      = 100
    @comp.length      = 100
    @comp.start_angle = 0
    @comp.end_angle   = 90
    @comp.ticks       = 10
    @comp.thickness   = 1
    @comp.color       = "ffffff"
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s   
      buff.scan( /<line/ ).size.should == 10
      buff.scan( /x1=\"(.*?\d+)\"/ ).should == [ ["1"], ["18"], ["35"], ["50"], ["65"], ["77"], ["87"], ["94"], ["99"], ["101"] ]
      buff.scan( /y1=\"(.*?\d+)\"/ ).should == [ ["-98"], ["-96"], ["-91"], ["-84"], ["-74"], ["-62"], ["-48"], ["-32"], ["-15"], ["1"] ]
      buff.scan( /x2=\"(.*?\d+)\"/ ).should == [ ["1"], ["35"], ["69"], ["100"], ["129"], ["154"], ["174"], ["188"], ["197"], ["201"] ]
      buff.scan( /y2=\"(.*?\d+)\"/ ).should == [ ["-198"], ["-194"], ["-185"], ["-171"], ["-151"], ["-126"], ["-98"], ["-66"], ["-32"], ["1"] ]
    end
        
  end
end
