require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Charts::Base do
  include Ziya::Utils::Text
  
  before( :all ) do
    @types = %w[
      Area 
      Bar 
      Bubble
      CandleStick 
      Column 
      ColumnThreed 
      FloatingBar 
      FloatingColumn 
      Line 
      Mixed 
      ParallelThreedColumn 
      Pie 
      PieThreed 
      Polar 
      Scatter 
      StackedArea 
      StackedBar 
      StackedArea 
      StackedBar 
      StackedColumn 
      StackedThreedColumn
      StackedThreedArea
      AreaThreed
      Donut
      ImagePie
      ImageColumn
      Custom
    ]
  end
    
  describe "#initialize" do
    it "should create a set of charts correctly" do
      @types.each do |type|
        chart = Ziya::Charts.const_get( classify(type) ).new
        if type.index( /Threed/ )
          match = type.match( /(.*)Threed(.*)/ )
          if match[2] and !match[2].empty?
            chart.type.gsub(/ /, '' ).should == match[1].downcase + "3d" + match[2].downcase
          else
            chart.type.gsub(/ /, '' ).should == "3d" + match[1].downcase
          end
        elsif type == "Custom"
          chart.type.should be_empty
        else
          chart.type.gsub(/ /, '' ).should == type.downcase unless type == "Mixed"
        end
      end
    end
    
    it "should produce the correct xml for a line chart with styles" do
      chart = Ziya::Charts::Line.new( "aaa" )
      chart.add( :axis_category_text, %w[fox dog] )
      chart.add( :series, "test", [10, 20], %w[label1 label2] )
      chart.to_xml.index( "color=\"0\"" ).should_not be_nil
    end
    
    it "should overide styles for a line chart with an id defined" do
      chart = Ziya::Charts::Line.new( "aaa", "fred" )
      chart.add( :axis_category_text, %w[fox dog] )
      chart.add( :series, "test", [10, 20], %w[label1 label2] )
      chart.to_xml.index( "color=\"ffffff\"" ).should_not be_nil
    end
  end
end