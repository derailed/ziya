require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Charts::Support::ChartPref do
  before( :each ) do
    @comp = Ziya::Charts::Support::ChartPref.new
  end
    
  it "should define the correct attribute methods" do
    lambda{ Ziya::Charts::Support::ChartPref.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
    
  describe "#flatten" do
    before( :each ) do
      @xml = Builder::XmlMarkup.new
    end  
    
    it "should flatten line point shape correctly" do
      @comp.point_shape = "square"
      @comp.flatten( @xml ).should == '<chart_pref point_shape="square"/>'
    end
    
    it "should flatten line connect correctly" do
      @comp.connect = true
      @comp.point_shape = 'square'
      @comp.flatten( @xml ).should == '<chart_pref connect="true" point_shape="square"/>'
    end

    it "should flatten zero line correctly" do
      @comp.zero_line = true
      @comp.point_shape = 'square'
      @comp.flatten( @xml ).should == '<chart_pref point_shape="square" zero_line="true"/>'
    end
    
  end
end
