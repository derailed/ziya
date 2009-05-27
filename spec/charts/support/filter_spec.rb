require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Charts::Support::Filter do
  before( :each ) do
    @comp = Ziya::Charts::Support::Filter.new
    blur = Ziya::Charts::Support::Blur.new
    blur.blurX = 10
    glow = Ziya::Charts::Support::Glow.new
    glow.alpha = 50
    @comp.filters = [blur, glow]
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Charts::Support::Filter.attributes[@comp.class.name].each {
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
