require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))
require 'ziya/core_ext/string'

describe String do  
  describe "#ziya_camelize" do
    describe "it should strip module info and camelize string correctly" do
      "fred/blee/hello_world".ziya_camelize.should == "Fred::Blee::HelloWorld"
    end
  
    describe "it should camelize a string correctly" do
      "hello_world".ziya_camelize.should == "HelloWorld"
    end
    
    describe "it should camelize a plural class correctly" do
      "axis_ticks".ziya_camelize.should == "AxisTicks"
    end
  end
  
  describe "#underscore" do
    describe "it should underscore a class name correctly" do
      "Fred::Blee::HelloWorld".ziya_underscore.should == "fred/blee/hello_world"
    end

    describe "it should underscore a name correctly" do
      "HelloWorld".ziya_underscore.should == "hello_world"
    end    
  end
  
  describe "#ziya_classify" do
    it "should create a class name correctly" do
      "/fred.blee.hello_world".ziya_classify.should == "HelloWorld"
    end
  end
  
  describe "#ziya_demodulize" do
    it "should strip module info correctly" do
      "Fred::Blee::HelloWorld".ziya_demodulize.should == "HelloWorld"
    end
  end
end
