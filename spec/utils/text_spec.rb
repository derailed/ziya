require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Utils::Text do  
  describe "camelize" do
    it "should camelize a plain string correctly" do
      camelize( "fred" ).should == "Fred"
    end
    
    it "shoud camelize a class name correctly" do
      camelize( "hello_world" ).should == "HelloWorld"
    end
    
    it "should camelize a namespace class file correctly" do
      camelize( "/blee/fred/hello_world" ).should == "::Blee::Fred::HelloWorld"
    end
  end
  
  describe "underscore" do
    it "should underscore a plain string" do
      underscore( "fred" ).should == "fred"
    end
    
    it "should underscore a camel cased string" do
      underscore( "HelloWorld" ).should == "hello_world"
    end
  end
  
  describe "classify" do
    it "should classify an attribute correctly" do
      classify( "fred.blee_duh" ).should == "BleeDuh"
    end
  end
end
