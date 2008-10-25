require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::Draw do
  before( :each ) do
    @comp  = Ziya::Components::Draw.new
    circle = Ziya::Components::Circle.new
    circle.radius = 10
    image   = Ziya::Components::Image.new
    image.x = 10
    @comp.components = [circle, image]
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::Draw.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml = Builder::XmlMarkup.new
    end
        
    it "should flatten component correctly" do
      @comp.flatten( @xml ).should == "<draw><circle radius=\"10\"/><image x=\"10\"/></draw>"
    end
    
    it "should support composite charts" do
      urls = { :fred => "/fred", :blee => "/blee" }
      @comp.flatten( @xml, urls ).should == "<draw><circle radius=\"10\"/><image x=\"10\"/><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=%2Ffred&amp;chart_id=fred\"/><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=%2Fblee&amp;chart_id=blee\"/></draw>"
    end
    
    it "should support js based composite chart" do 
      urls = { :fred => nil }
      @comp.flatten( @xml, urls ).should == "<draw><circle radius=\"10\"/><image x=\"10\"/><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;chart_id=fred\"/></draw>"
    end
  end    
end
