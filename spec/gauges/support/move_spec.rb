require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Move do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Move.new(
      :start_x_offset  => 3,
      :start_y_offset  => 30,
      :end_x_offset    => 25,
      :end_y_offset    => 100,
      :step            => 0,
      :shake_span      => 10,
      :shake_frequency => 100,
      :shake_snap      => 10,
      :shadow_alpha    => 100,
      :shadow_x_offset => 10,
      :shadow_y_offset => 20,      
      :components      => YAML::Omap[
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
      buff.scan( /<point/ ).size.should == 2
      buff.scan( /\sx=\"(.*?\d+)\"/ ).should == [ ["10"], ["20"] ]
      buff.scan( /\sy=\"(.*?\d+)\"/ ).should == [ ["20"], ["30"] ]
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
