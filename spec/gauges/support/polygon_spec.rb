require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Polygon do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Polygon.new(
      :fill_color     => "ffffff",
      :fill_alpha     => 100,
      :line_color     => "ff00ff",
      :line_alpha     => 100,
      :line_thickness => 0,
      :components     => YAML::Omap[
        :point_1, Ziya::Gauges::Support::Point.new( :x => 10, :y => 20 ), 
        :point_2, Ziya::Gauges::Support::Point.new( :x => 20, :y => 30 )
      ] )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s    
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /#{attr}=\"(\w+)\"/ ).should == [ [@comp.send( attr ).to_s] ] unless attr == :components
      end
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
