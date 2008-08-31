require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::Link do
  before( :all ) do
    @area1 = Ziya::Gauges::Support::Area.new( :x => 10, :y => 20, :width => 100, :height => 200 )    
    @area2 = Ziya::Gauges::Support::Area.new( :x => 20, :y => 30, :width => 100, :height => 200 )    
    @comp  = Ziya::Gauges::Support::Link.new( 
      :components => YAML::Omap[
        :area_1, @area1, 
        :area_2, @area2
      ] )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s  
      buff.scan( /<area/ ).size.should == 2
      buff.scan( /x=\"(.*?\d+)\"/ ).should      == [ ["10"], ["20"] ]
      buff.scan( /y=\"(.*?\d+)\"/ ).should      == [ ["20"], ["30"] ]
      buff.scan( /width=\"(.*?\d+)\"/ ).should  == [ ["100"], ["100"] ]
      buff.scan( /height=\"(.*?\d+)\"/ ).should == [ ["200"], ["200"] ]
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
