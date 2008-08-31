require File.expand_path(File.join(File.dirname(__FILE__), %w[spec_helper]))

describe Ziya do
  before( :all ) do        
    @root = ::File.expand_path( ::File.join(::File.dirname(__FILE__), ".." ) )
  end
                                 
  it "is versioned" do
    ::Ziya::Version.version.should =~ /\d+\.\d+\.\d+/
  end
    
  it "generates a correct path relative to root" do
    ::Ziya.path( "ziya.rb" ).should == ::File.join( @root, "ziya.rb" )
  end
  
  it "generates a correct path relative to lib" do
    ::Ziya.libpath(%w[ ziya utils.rb]).should == ::File.join( @root, "lib", "ziya", "utils.rb" )
  end         
end
