require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Scale do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Scale.new(
      :x               => 3,
      :y               => 30,
      :start_scale     => 25,
      :end_scale       => 100,
      :step            => 0,
      :direction       => 10,
      :shake_span      => 100,
      :shake_frequency => 10,
      :shake_snap      => 20,
      :shadow_alpha    => 100,
      :shadow_x_offset => 10,
      :shadow_y_offset => 20,      
      :components      => YAML::Omap[
        :line1, Ziya::Gauges::Support::Line.new( :x1 => 10, :y1 => 20 ), 
        :line2, Ziya::Gauges::Support::Line.new( :x1 => 20, :y1 => 30 )
      ] )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s  
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /\s#{attr}=\"(\w+)\"/ ).should == [ [@comp.send( attr ).to_s] ] unless attr == :components
      end
      buff.scan( /<line/ ).size.should == 2
      buff.scan( /\sx1=\"(.*?\d+)\"/ ).should == [ ["10"], ["20"] ]
      buff.scan( /\sy1=\"(.*?\d+)\"/ ).should == [ ["20"], ["30"] ]
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
