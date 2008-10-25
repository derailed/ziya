require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Charts::Base do
  before( :each ) do
    @chart = Ziya::Charts::Base.new
  end
    
  describe "#initialize" do
    before( :each ) do
      @chart = Ziya::Charts::Base.new( "test_license", "test_id" ) 
    end
    
    it "should create a chart with the correct license" do
      @chart.license.should == "test_license"
    end    
    
    it "should create a chart with the correct id" do
      @chart.id.should == "test_id"
    end        
  end    
  
  describe "it should produce the correct xml for a basic chart" do
    chart = Ziya::Charts::Base.new( "aaa" )
    chart.add( :axis_category_text, %w[fox dog] )
    chart.add( :series, "test", [10, 20] )
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><license>aaa</license><chart_data><row><null/><string>fox</string><string>dog</string></row><row><string>test</string><number>10</number><number>20</number></row></chart_data></chart>"
  end
    
  describe "#add" do
    before( :each ) do
      @chart = Ziya::Charts::Base.new
    end

    it "should support setting an axis category" do
      @chart.add( :axis_category_text, %w[fox cat dog] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>fox</string><string>cat</string><string>dog</string></row></chart_data></chart>"
    end    
    it "should error if the axis category is not an array" do
      lambda { @chart.add( :axis_category_text, "") }.should raise_error( ArgumentError, /array of categories/i )
    end    
    
    it "should support setting a composite chart urls" do
      @chart.add( :composites, { :fred => "url1", :blee => "url2" } )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><draw><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=url1&amp;chart_id=fred\"/><image url=\"/charts/charts.swf?library_path=/charts/charts_library&amp;xml_source=url2&amp;chart_id=blee\"/></draw></chart>"
    end    
    it "should error if the composite url arg is not an array" do
      lambda { @chart.add( :composites, "") }.should raise_error( ArgumentError, /hash of id => url/ )
    end    
    
    it "should support setting the axis_value label" do
      @chart.add( :axis_category_text, %w[dog cat] )        
      @chart.add( :axis_value_label, %w[blee duh] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row></chart_data><axis_value_label><string>blee</string><string>duh</string></axis_value_label></chart>"
    end    
    it "should error if the axis value label arg is not an array" do
      lambda { @chart.add( :axis_value_label, "") }.should raise_error( ArgumentError, /array of values/i )
    end    

    it "should support setting the axis category label" do
      @chart.add( :axis_category_text, %w[dog cat] )        
      @chart.add( :axis_category_label, %w[blee duh] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row></chart_data><axis_category_label><string>blee</string><string>duh</string></axis_category_label></chart>"
    end    
    it "should error if the axis category label arg is not an array" do
      lambda { @chart.add( :axis_category_label, "") }.should raise_error( ArgumentError, /array of category/i )
    end    
    
    it "should support adding series" do
      @chart.add( :axis_category_text, %w[dog cat] )      
      @chart.add( :series, "test", %w[10 20] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row><row><string>test</string><string>10</string><string>20</string></row></chart_data></chart>"
    end    
    
    it "should support adding labels to series" do
      @chart.add( :axis_category_text, %w[dog cat] )
      @chart.add( :series, "test", [ {:value => 10, :label => "label1" }, { :value => 20, :label => "label2" } ] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row><row><string>test</string><number label=\"label1\">10</number><number label=\"label2\">20</number></row></chart_data></chart>"
    end

    it "should support adding filters to series" do
      @chart.add( :axis_category_text, %w[dog cat] )
      @chart.add( :series, "test", [ {:value => 10, :glow => "glow1" }, { :value => 20, :blur => "blur2" } ] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row><row><string>test</string><number glow=\"glow1\">10</number><number blur=\"blur2\">20</number></row></chart_data></chart>"
    end

    it "should support adding an image to a series" do
      @chart.add( :axis_category_text, %w[dog cat] )
      @chart.add( :series, "test", [ 10, 20 ], "some_url" )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_data><row><null/><string>dog</string><string>cat</string></row><row url=\"some_url\"><string>test</string><number>10</number><number>20</number></row></chart_data></chart>"
    end

    # BOZO !! Review    
    it "should error if a series is defined but no axis_category is specified" do
      # @chart.add( :series, "test", [10,20] )      
      # lambda { @chart.to_xml }.should raise_error( RuntimeError, /axis_category_text/i )
    end 
    
    it "should accept a series with no name" do
      lambda { @chart.add( :series, "", [10,20]) }.should_not raise_error
    end 
       
    it "should error if the series is not an array" do
      lambda { @chart.add( :series, "test", nil) }.should raise_error( ArgumentError, /data points/i )
    end    
    
    it "should error if the user data has no key" do
      lambda { @chart.add( :user_data, nil) }.should raise_error( ArgumentError, /specify a key/i )
    end    
    it "should error if the user data has no key" do
      lambda { @chart.add( :user_data, :fred, "blee") }.should_not raise_error( ArgumentError, /specify a key/i )
    end    
    
    it "should support setting yaml styles directly" do
      @chart.add( :styles, "--- !ruby/object:Ziya::Charts::Base\n" )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart></chart>"
    end    
    it "should error if no style is specified" do
      lambda { @chart.add( :styles, "") }.should raise_error( ArgumentError, /set of styles/i )
    end    
    
    it "should support mixed charts" do
      @chart.add( :chart_types, %w[line bar] )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart><chart_type><string>line</string><string>bar</string></chart_type></chart>"
    end    
    it "should error if no chart types are specified" do
      lambda { @chart.add( :chart_types, "") }.should raise_error( ArgumentError, /set of chart types/i )
    end    
    
    it "should support setting a themes" do
      @chart.add( :theme, "blee" )
      @chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><chart></chart>"
    end    
    it "should error if no chart types are specified" do
      lambda { @chart.add( :theme, "") }.should raise_error( ArgumentError, /theme name/i )
    end    
    
    it "should error if an invalid option is specified" do
      lambda { @chart.add( :fred, "") }.should raise_error( ArgumentError, /invalid directive/i )
    end        
  end
end
