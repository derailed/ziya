require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Charts::Support::Draw do
  before( :each ) do
    @comp  = Ziya::Charts::Support::Draw.new
    circle = Ziya::Charts::Support::Circle.new
    circle.radius = 10
    image   = Ziya::Charts::Support::Image.new
    image.x = 10
    text   = Ziya::Charts::Support::Text.new
    text.x = 20
    # text.y = 10
    text.text = "Hello World"
    @comp.components = [circle, image, text]
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Charts::Support::Draw.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml = Builder::XmlMarkup.new
    end
        
    it "should flatten component correctly" do
      @comp.flatten( @xml ).should == "<draw><circle radius=\"10\"/><image x=\"10\"/><text x=\"20\">Hello World</text></draw>"
    end
    
    it "should support composite charts" do
      urls = { :fred => { :url => "/fred" }, :blee => { :url => "/blee" } }
      @comp.flatten( @xml, urls ).should == "<draw><circle radius=\"10\"/><image x=\"10\"/><text x=\"20\">Hello World</text><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=%2Fblee&amp;chart_id=blee\"/><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=%2Ffred&amp;chart_id=fred\"/></draw>"
    end
    
    it "should support composite chart with options" do 
      urls = { :fred => { :url => "/fred", :transition => "slide_left", :duration => 1 } }
      @comp.flatten( @xml, urls ).index( "transition=\"slide_left\"" ).should_not be_nil
    end
  end    
end
