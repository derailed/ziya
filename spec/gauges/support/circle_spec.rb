require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Circle do
  before( :each ) do
    @comp = Ziya::Gauges::Support::Circle.new(
      :x      => 1,
      :y      => 2,
      :radius => 100 )
  end
  
  it "should have some options" do
    @comp.options.should == { :radius => 100, :x => 1, :y => 2 }
  end
  
  it "should convert a gauge to yaml correctly" do
    circle = YAML.load( @comp.to_comp_yaml( :test, 1 ) ).first[:test]
    circle.is_a?( Ziya::Gauges::Support::Circle ).should == true
    circle.x.should      == 1
    circle.y.should      == 2
    circle.radius.should == 100
  end
  
  it "should have options as string" do
    @comp.options_as_string.should == ":radius => '100',:x => '1',:y => '2'"
  end
  
  it "should define the correct attribute methods" do
    lambda{ Ziya::Gauges::Support::Circle.attributes[@comp.class.name].each {
     |m| @comp.send( m ) } }.should_not raise_error
  end
  
  it "should check that a component has been configured" do
    @comp.should be_configured
  end

  it "should check that a component has not beem configured" do
    @comp = Ziya::Gauges::Support::Circle.new    
    @comp.should_not be_configured
  end
  
  it "should merge attributes correctly" do
    parent = Ziya::Gauges::Support::Circle.new
    parent.x = 20
    parent.y = 50
    @comp.merge( parent, false )
    parent.options_as_string.should == ":x => '20',:y => '50'"
    @comp.options_as_string.should  == ":radius => '100',:x => '20',:y => '50'"    
  end

  describe "#flatten" do  
    it "should flatten component correctly" do
      xml          = Builder::XmlMarkup.new
      compare( @comp.flatten( xml ), { :circle => nil, :x => 1, :y => 2, :radius => 100 } )
    end
    
    it "should flatten simple component correctly" do
      xml  = Builder::XmlMarkup.new
      comp = Ziya::Gauges::Support::Circle.new
      comp.x = 10
      comp.flatten( xml ).should == "<circle x=\"10\"/>"
    end    
  end
  
  def compare( result, hash )
    result = result.gsub( /[<|\/>]/, '' )
    tokens = result.split( " " )
    tokens.size.should == hash.size
    tokens.each do |t|
      if t.index( /=/ )
        kvs = t.split( "=" )
        hash.has_key?( kvs.first.to_sym ).should == true
        kvs[1].gsub( /"/, '').should == hash[kvs[0].to_sym].to_s
      else
        hash.has_key?( t.to_sym ).should == true
      end
    end      
  end
end
