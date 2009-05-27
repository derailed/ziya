require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))
require 'ziya/core_ext/string'

describe String do  
  describe "#camelize_it" do
    describe "it should strip module info and camelize string correctly" do
      "fred/blee/hello_world".camelize_it.should == "Fred::Blee::HelloWorld"
    end
  
    describe "it should camelize a string correctly" do
      "hello_world".camelize_it.should == "HelloWorld"
    end
    
    describe "it should camelize a plural class correctly" do
      "axis_ticks".camelize_it.should == "AxisTicks"
    end
  end
  
  describe "#underscore" do
    describe "it should underscore a class name correctly" do
      "Fred::Blee::HelloWorld".underscore.should == "fred/blee/hello_world"
    end

    describe "it should underscore a name correctly" do
      "HelloWorld".underscore.should == "hello_world"
    end    
  end
  
  describe "#classify" do
    it "should create a class name correctly" do
      "/fred.blee.hello_world".classify.should == "HelloWorld"
    end
  end
  
  describe "#demodulize" do
    it "should strip module info correctly" do
      "Fred::Blee::HelloWorld".demodulize.should == "HelloWorld"
    end
  end
end
