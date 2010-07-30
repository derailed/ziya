require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Maps::Support::HeatRange do
  before( :all ) do
    @comp = Ziya::Maps::Support::HeatRange.new(
      :base_color => "ff00ff",
      :min        => 0,
      :max        => 100,
      :step       => 10,
      :color_step => 90 )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      buff = ''
      xml = Builder::XmlMarkup.new( :target => buff )
      @comp.flatten( xml )
      buff.should == "<state id=\"range\"><data>0 - 9</data><color>ff00ff</color></state><state id=\"range\"><data>10 - 19</data><color>e600e6</color></state><state id=\"range\"><data>20 - 29</data><color>cf00cf</color></state><state id=\"range\"><data>30 - 39</data><color>ba00ba</color></state><state id=\"range\"><data>40 - 49</data><color>a700a7</color></state><state id=\"range\"><data>50 - 59</data><color>970097</color></state><state id=\"range\"><data>60 - 69</data><color>880088</color></state><state id=\"range\"><data>70 - 79</data><color>7a007a</color></state><state id=\"range\"><data>80 - 89</data><color>6e006e</color></state><state id=\"range\"><data>90 - 99</data><color>630063</color></state>"
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
