require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Components::SeriesExplode do
  before( :each ) do
    @comp = Ziya::Components::SeriesExplode.new
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Components::SeriesExplode.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml     = Builder::XmlMarkup.new
      @results = "<series_explode><number>10</number><number>20</number><number>30</number></series_explode>"
    end  
    
    it "should flatten string explode version correctly" do
      @comp.numbers = "10,20,30"
      @comp.flatten( @xml ).should == @results
    end

    it "should flatten string numbers with spaces explode version correctly" do
      @comp.numbers = "10 , 20 , 30"
      @comp.flatten( @xml ).should == @results
    end

    it "should flatten single string explode version correctly" do    
      @comp.numbers = 10
      @comp.flatten( @xml ).should == "<series_explode><number>10</number></series_explode>"
    end
    
    it "should flatten array explode version correctly" do    
      @comp.numbers = %w[10 20 30]
      @comp.flatten( @xml ).should == @results
    end    
  end
end
