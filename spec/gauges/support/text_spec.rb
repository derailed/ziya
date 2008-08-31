require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Text do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Text.new(
      :x           => 1,
      :y           => 2,
      :width       => 100,
      :height      => 100,
      :rotation    => 0,
      :font        => "arial",
      :bold        => true,
      :size        => 1,
      :align       => "left",
      :color       => "ffffff",
      :alpha       => 100,
      :text        => "Hello Bubba !!" )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s  
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /#{attr}=\"(\w+)\"/ ).should == [ [@comp.send( attr ).to_s] ] unless attr == :text
      end
      buff.scan( />(#{@comp.text})<\/text>/ ).should == [ [@comp.text] ]
    end        
  end
  
  describe "YAML load" do
    it "should load from yaml correctly" do
      comp = YAML.load( @comp.to_comp_yaml( :test, 1 ) ).first[:test]
      @comp.options.each_pair do |k,v|
        comp.send( k ).should == v
      end
    end
  end
end
