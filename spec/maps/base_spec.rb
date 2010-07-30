require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Maps::Base do  
  describe "it should produce the correct xml for a simple map" do
    chart = Ziya::Maps::Base.new( :world )
    chart.add :theme, "maps"
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><countrydata><state id=\"arc_color\"><color>0000ff</color></state><state id=\"background_color\"><opacity>0</opacity></state><state id=\"default_color\"><color>bbbbbb</color></state><state id=\"default_point\"><color>ff0000</color><opacity>70</opacity><size>20</size><src>fred.gif</src></state><state id=\"first_zoom\"><data>TX</data></state><state id=\"hover\"><background_color>0</background_color><font_color>ffffff</font_color><font_size>14</font_size></state><state id=\"line_color\"><color>00ff00</color></state><state id=\"outline_color\"><color>0</color></state><state id=\"range\"><color>cc0033</color><data>1</data></state><state id=\"range\"><color>bb0033</color><data>1 - 10</data></state><state id=\"scale_points\"><data>50</data></state><state id=\"show_name\"><data>region</data></state><state id=\"zoom_mode\"><data>no_zoom</data></state><state id=\"zoom_out_button\"><background_color>0000ff</background_color><data>S</data><font_color>00ff00</font_color><font_size>14</font_size><name>Zoum out</name></state><state id=\"zoom_out_scale\"><data>200</data></state></countrydata>"
  end    
  
  describe "it should generate a correct us heat map with states" do
    chart = Ziya::Maps::Base.new( :us )
    chart.add :series, 
    {
      "CO" => { :name => "Colorado"  , :data => 2, :hover => "Blah", :url => "cnn.com"   , :target => "_blank" },
      "CA" => { :name => "California", :data => 1, :hover => "Duh" , :url => "google.com", :target => "_blank" }      
    }
    chart.add :theme, "maps"
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><us_states><state id=\"arc_color\"><color>0000ff</color></state><state id=\"background_color\"><opacity>0</opacity></state><state id=\"default_color\"><color>bbbbbb</color></state><state id=\"default_point\"><color>ff0000</color><opacity>70</opacity><size>20</size><src>fred.gif</src></state><state id=\"first_zoom\"><data>TX</data></state><state id=\"hover\"><background_color>0</background_color><font_color>ffffff</font_color><font_size>14</font_size></state><state id=\"line_color\"><color>00ff00</color></state><state id=\"outline_color\"><color>0</color></state><state id=\"range\"><color>cc0033</color><data>1</data></state><state id=\"range\"><color>bb0033</color><data>1 - 10</data></state><state id=\"scale_points\"><data>50</data></state><state id=\"show_name\"><data>region</data></state><state id=\"zoom_mode\"><data>no_zoom</data></state><state id=\"zoom_out_button\"><background_color>0000ff</background_color><data>S</data><font_color>00ff00</font_color><font_size>14</font_size><name>Zoum out</name></state><state id=\"zoom_out_scale\"><data>200</data></state><state id=\"CA\"><data>1</data><hover>Duh</hover><name>California</name><target>_blank</target><url>google.com</url></state><state id=\"CO\"><data>2</data><hover>Blah</hover><name>Colorado</name><target>_blank</target><url>cnn.com</url></state></us_states>"
  end    
  
  describe "it should generate color ranges correctly" do
    chart = Ziya::Maps::Base.new( :us )
    chart.add :series,
    {
      "CO" => { :name => "Colorado"  , :data => 2, :hover => "Blah", :url => "cnn.com"   , :target => "_blank" },
      "CA" => { :name => "California", :data => 1, :hover => "Duh" , :url => "google.com", :target => "_blank" }      
    }
    chart.add :range_colors,
    {
      '1'      => "ff0000",
      '2'      => '00ff00',
      '2 - 10' => '0000ff'
    }
    chart.add :theme, "maps" 
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><us_states><state id=\"arc_color\"><color>0000ff</color></state><state id=\"background_color\"><opacity>0</opacity></state><state id=\"default_color\"><color>bbbbbb</color></state><state id=\"default_point\"><color>ff0000</color><opacity>70</opacity><size>20</size><src>fred.gif</src></state><state id=\"first_zoom\"><data>TX</data></state><state id=\"hover\"><background_color>0</background_color><font_color>ffffff</font_color><font_size>14</font_size></state><state id=\"line_color\"><color>00ff00</color></state><state id=\"outline_color\"><color>0</color></state><state id=\"range\"><color>cc0033</color><data>1</data></state><state id=\"range\"><color>bb0033</color><data>1 - 10</data></state><state id=\"scale_points\"><data>50</data></state><state id=\"show_name\"><data>region</data></state><state id=\"zoom_mode\"><data>no_zoom</data></state><state id=\"zoom_out_button\"><background_color>0000ff</background_color><data>S</data><font_color>00ff00</font_color><font_size>14</font_size><name>Zoum out</name></state><state id=\"zoom_out_scale\"><data>200</data></state><state id=\"CA\"><data>1</data><hover>Duh</hover><name>California</name><target>_blank</target><url>google.com</url></state><state id=\"CO\"><data>2</data><hover>Blah</hover><name>Colorado</name><target>_blank</target><url>cnn.com</url></state><state id=\"range\"><data>1</data><color>ff0000</color></state><state id=\"range\"><data>2</data><color>00ff00</color></state><state id=\"range\"><data>2 - 10</data><color>0000ff</color></state></us_states>"
  end
  
  describe 'it should add points correctly' do
    chart = Ziya::Maps::Base.new( :us )
    chart.add :points, 
    { 
      "test_1" => { :data => 1, :loc => Ziya::Maps::Geocode.new( 0, 0 ) },
      "test_2" => { :data => 2, :loc => Ziya::Maps::Geocode.new( 10, 10 ) } 
    }
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><us_states><state id=\"point\"><name>test_1</name><data>1</data><loc>0,0</loc></state><state id=\"point\"><name>test_2</name><data>2</data><loc>10,10</loc></state></us_states>"
  end

  describe 'it should add lines correctly' do
    chart = Ziya::Maps::Base.new( :world )
    chart.add :lines, 
    { 
      "test_1" => { 
        :data   => 1, 
        :start  => Ziya::Maps::Geocode.new( 0, 0 ), 
        :end    => Ziya::Maps::Geocode.new( 10, 10 ), 
        :stroke => 1 },
      "test_2" => { 
        :data   => 2, 
        :start  => Ziya::Maps::Geocode.new( 20, 20 ), 
        :end    => Ziya::Maps::Geocode.new( 30, 30 ), 
        :stroke => 2 } 
    }
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><countrydata><state id=\"line\"><name>test_1</name><data>1</data><end>10,10</end><start>0,0</start><stroke>1</stroke></state><state id=\"line\"><name>test_2</name><data>2</data><end>30,30</end><start>20,20</start><stroke>2</stroke></state></countrydata>"
  end

  describe 'it should add arcs correctly' do
    chart = Ziya::Maps::Base.new( :world )
    chart.add :arcs, 
    { 
      "test_1" => { 
        :data   => 1, 
        :start  => Ziya::Maps::Geocode.new( 0, 0 ), 
        :end    => Ziya::Maps::Geocode.new( 10, 10 ) },
      "test_2" => { 
        :data   => 2, 
        :start  => Ziya::Maps::Geocode.new( 20, 20 ), 
        :end    => Ziya::Maps::Geocode.new( 30, 30 ) } 
    }
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><countrydata><state id=\"arc\"><name>test_1</name><data>1</data><end>10,10</end><start>0,0</start></state><state id=\"arc\"><name>test_2</name><data>2</data><end>30,30</end><start>20,20</start></state></countrydata>"
  end
  
end
