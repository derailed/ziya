require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::Link do
  before( :each ) do
    @comp = Ziya::Components::Link.new
    area1 = Ziya::Components::Area.new
    area1.x = 10
    area2 = Ziya::Components::Area.new
    area2.x = 20
    @comp.areas = [area1, area2]
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::Link.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  it "should flatten component correctly" do
    xml = Builder::XmlMarkup.new
    @comp.flatten( xml ).should == "<link><area x=\"10\"/><area x=\"20\"/></link>"
  end
end
