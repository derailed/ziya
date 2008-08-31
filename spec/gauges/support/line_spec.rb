require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Line do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Line.new(
      :x1               => 10,
      :y1               => 20,
      :x2               => 100,
      :y2               => 200,
      :color            => "ff00ff",
      :thickness        => 90,
      :alpha            => 10 )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s  
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /#{attr}=\"(\w+)\"/ ).should == [ [@comp.send( attr ).to_s] ] unless attr == :retry
      end
    end
  end
  
  describe "YAML load" do
    it "should load from yaml correctly" do
      comp = YAML.load( @comp.to_comp_yaml( :test, 1 ) ).first[:test]
      @comp.options.each_pair do |k,v|
        comp.send( k ).to_s.should == v.to_s
      end
    end
  end
end
