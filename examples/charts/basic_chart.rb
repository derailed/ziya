require 'rubygems'
require 'sinatra'
require 'builder'

# require ZiYa gem and helpers
require 'ziya'
require 'ziya/html_helpers'
require 'ziya/yaml_helpers'

# initialize ZiYa environment
configure do
  Ziya.initialize( 
    :log_level  => :debug,
    :themes_dir => File.join( File.dirname(__FILE__), %w[public charts themes] ) )
end

helpers do
  # add ZiYa helpers
  include Ziya::HtmlHelpers::Charts
  include Ziya::YamlHelpers::Charts
  
  # Default chart
  def gen_chart
    chart = Ziya::Charts::Column.new
    chart.add :axis_category_text, %w[2007 2008 2009]
    chart.add :series, 'dogs', [10,20,30]
    chart.add :series, 'cats', [5,15,25]
    chart    
  end
end

# Setup chart and callbacks
get '/' do
  erb :index
end

# defines a simple column chart
get '/load_chart' do
  gen_chart.to_xml
end

# exact same chart as above but styled
get '/load_themed_chart' do
  chart = gen_chart
  chart.add :theme , 'cool_theme'
  chart.to_xml  
end