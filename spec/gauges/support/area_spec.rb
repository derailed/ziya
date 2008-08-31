require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Area do
  before( :all ) do
    @comp = Ziya::Gauges::Support::Area.new(
      :x                => 10,
      :y                => 20,
      :width            => 200,
      :height           => 100,
      :url              => "blee",
      :target           => "_self",
      :text             => "Hello",
      :font             => "arial",     
      :bold             => "false",
      :size             => 10,    
      :color            => "ff00ff",
      :alpha            => 10,
      :stop_sound       => "false" )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s  
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /#{attr}=\"(\w+)\"/ ).should == [ [@comp.send( attr ).to_s] ] unless attr == :background_color
      end
    end
  end
  
  describe "YAML load" do
    it "should load from yaml correctly" do
      comp = YAML.load( @comp.to_yaml )
      @comp.options.each_pair do |k,v|
        comp.send( k ).to_s.should == v.to_s
      end
    end
  end
end
