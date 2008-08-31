require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::Filter do
  before( :each ) do
    @comp = Ziya::Components::Filter.new
    blur = Ziya::Components::Blur.new
    blur.blurX = 10
    glow = Ziya::Components::Glow.new
    glow.alpha = 50
    @comp.filters = [blur, glow]
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::Filter.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml = Builder::XmlMarkup.new
    end
        
    it "should flatten component correctly" do
      @comp.flatten( @xml ).should == "<filter><blur blurX=\"10\"/><glow alpha=\"50\"/></filter>"
    end    
  end    
end
