require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Maps::Support::DefaultColor do
  before( :all ) do
    @comp = Ziya::Maps::Support::DefaultColor.new(
      :color   => "ff00ff",
      :opacity => 10 )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      buff = ''
      xml = Builder::XmlMarkup.new( :target => buff )
      @comp.flatten( xml )
      @comp.class.attributes[@comp.class.name].each do |attr|
        buff.scan( /<#{attr}>(\w+)<\/#{attr}>/ ).should == [ [@comp.send( attr ).to_s] ]
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
