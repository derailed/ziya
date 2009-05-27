require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::YamlHelpers::Gauges do    
  
  include Ziya::YamlHelpers::Gauges
      
  it "should generate the correct yaml for a gauge" do
    gauge( "fred" ).should == "--- !ruby/object:Ziya::Gauges::Fred\ncomponents: !omap"
  end

  it "should generate the correct yaml for a dial" do
    dial( :circle, :blee ).should == "- :blee: !ruby/object:Ziya::Gauges::Support::Circle"
  end
  
end
