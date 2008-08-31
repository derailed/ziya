require File.expand_path(File.join(File.dirname(__FILE__), %w[.. .. spec_helper]))

describe Ziya::Gauges::Support::RadialNumbers do
  before( :each ) do
    @comp = Ziya::Gauges::Support::RadialNumbers.new(
      :x           => 10,
      :y           => 10,
      :radius      => 200,
      :start_num   => 1,
      :end_num     => 10,
      :start_angle => 0,
      :end_angle   => 180,
      :ticks       => 10,
      :font        => "arial",
      :bold        => "false",
      :align       => "left",
      :width       => 100,
      :height      => 100,
      :size        => 10,
      :color       => "ffffff" )
  end
  
  describe "#flatten" do  
    it "should flatten component correctly" do
      xml = Builder::XmlMarkup.new
      @comp.flatten( xml )
      buff = xml.to_s   
      buff.scan( /<text/ ).size.should == 10
      buff.scan( /x=\"(.*?\d+)\"/ ).should == [ ["10"], ["78"], ["138"], ["183"], ["206"], ["206"], ["183"], ["138"], ["78"], ["10"] ]
      buff.scan( /y=\"(.*?\d+)\"/ ).should == [ ["-190"], ["-177"], ["-143"], ["-90"], ["-24"], ["44"], ["109"], ["163"], ["197"], ["210"] ]
      buff.scan( />(\d+)<\/text>/ ).should == [ ["1"], ["2"], ["3"], ["4"], ["5"], ["6"], ["7"], ["8"], ["9"], ["10"] ]
    end
        
  end
end
