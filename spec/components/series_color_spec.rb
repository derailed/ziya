require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::SeriesColor do
  before( :each ) do
    @comp = Ziya::Components::SeriesColor.new
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::SeriesColor.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml     = Builder::XmlMarkup.new
      @results = "<series_color><color>10</color><color>20</color><color>30</color></series_color>"
    end  
    
    it "should flatten string explode version correctly" do
      @comp.colors = "10,20,30"
      @comp.flatten( @xml ).should == @results
    end

    it "should flatten string numbers with spaces explode version correctly" do
      @comp.colors = "10 , 20 , 30"
      @comp.flatten( @xml ).should == @results
    end

    it "should flatten single string explode version correctly" do    
      @comp.colors = 10
      @comp.flatten( @xml ).should == "<series_color><color>10</color></series_color>"
    end
    
    it "should flatten array explode version correctly" do    
      @comp.colors = %w[10 20 30]
      @comp.flatten( @xml ).should == @results
    end    
  end
end
