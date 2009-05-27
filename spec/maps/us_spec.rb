require File.expand_path(File.join(File.dirname(__FILE__), %w[.. spec_helper]))

describe Ziya::Maps::Us do  
  
  describe "it should produce the correct xml for a simple map" do
    chart = Ziya::Maps::Us.new
    chart.add :theme, "maps"
    chart.to_xml.should == "<?xml version=\"1.0\" encoding=\"UTF-8\"?><us_states><state id=\"arc_color\"><color>0000ff</color></state><state id=\"background_color\"><opacity>50</opacity></state><state id=\"default_color\"><color>0000ff</color></state><state id=\"default_point\"><color>ff0000</color><opacity>70</opacity><size>20</size><src>fred.gif</src></state><state id=\"first_zoom\"><data>TX</data></state><state id=\"hover\"><background_color>0</background_color><font_color>ffffff</font_color><font_size>14</font_size></state><state id=\"line_color\"><color>00ff00</color></state><state id=\"outline_color\"><color>0</color></state><state id=\"range\"><color>cc0033</color><data>1</data></state><state id=\"range\"><color>bb0033</color><data>1 - 10</data></state><state id=\"scale_points\"><data>50</data></state><state id=\"show_name\"><data>region</data></state><state id=\"zoom_mode\"><data>no_zoom</data></state><state id=\"zoom_out_button\"><background_color>0000ff</background_color><data>S</data><font_color>00ff00</font_color><font_size>14</font_size><name>Zoum out</name></state><state id=\"zoom_out_scale\"><data>200</data></state></us_states>"
  end    

end
  