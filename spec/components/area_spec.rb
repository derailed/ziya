require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::Area do
  before( :each ) do
    @comp = Ziya::Components::Area.new
    @comp.x      = 1
    @comp.y      = 2
    @comp.width  = 100
    @comp.height = 200    
  end
  
  it "should have some options" do
    @comp.options.should == { :height => 200, :x => 1, :width => 100, :y => 2 }
  end
  
  it "should construct an area correctly" do
    area = Ziya::Components::Area.new( :height => 200, :width => 100, :x => 0, :y => 1 )
    area.height.should == 200
    area.width.should  == 100
    area.x.should      == 0
    area.y.should      == 1
  end
  
  it "should have no options as string" do
    @comp.options_as_string.should == ":height => '200',:width => '100',:x => '1',:y => '2'"
  end
  
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::Area.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
  
  it "should check that a component is not empty correctly" do
    @comp.should be_configured
  end

  it "should check that no properties are set correctly" do
    @comp = Ziya::Components::Area.new    
    @comp.should_not be_configured
  end
  
  it "should merge attributes correctly" do
    parent = Ziya::Components::Area.new
    parent.x = 20
    parent.y = 50
    @comp.merge( parent, false )
    parent.options_as_string.should == ":x => '20',:y => '50'"
    @comp.options_as_string.should  == ":height => '200',:width => '100',:x => '20',:y => '50'"    
  end

  describe "#flatten" do  
    it "should flatten component correctly" do
      xml          = Builder::XmlMarkup.new
      # BOZO !! Doh !! that would have been nice but the attrs order is unspecified in builder...
      # @comp.flatten( xml ).should == "<area width=\"100\" x=\"1\" y=\"2\" height=\"200\"/>"
      @comp.flatten( xml ).size.should == 44
    end
    
    it "should flatten simple component correctly" do
      xml  = Builder::XmlMarkup.new
      comp = Ziya::Components::Area.new
      comp.x = 10
      comp.flatten( xml ).should == "<area x=\"10\"/>"
    end
    
  end
end
