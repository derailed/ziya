require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::YamlHelpers::Charts do    
  
  include Ziya::YamlHelpers::Charts

  it "should generate the correct chart path" do
    chart_url( "http://test.me.com/blee" ).should == 
      "/charts/charts.swf?library_path=/charts/charts_library&xml_source=http%3A%2F%2Ftest.me.com%2Fblee"
  end
  
  it "should generate the correct chart path with root override" do
    chart_url( "http://test.me.com/blee", "/blees" ).should == 
      "/blees/charts.swf?library_path=/blees/charts_library&xml_source=http%3A%2F%2Ftest.me.com%2Fblee"
  end
  
  it "should generate the correct yaml class name" do
    component( "fred" ).should == "fred: !ruby/object:Ziya::Charts::Support::Fred"
  end
  
  it "should generate the correct yaml clqss name for alias" do
    comp( "fred" ).should == "fred: !ruby/object:Ziya::Charts::Support::Fred"
  end

  it "should generate the correct yaml drawing class name" do
    drawing( "fred" ).should == "!ruby/object:Ziya::Charts::Support::Fred"
  end

  it "should generate the correct yaml chart class name" do
    chart( "fred" ).should == "--- !ruby/object:Ziya::Charts::Fred"
  end
    
end
