require 'rubygems'
require 'sinatra'
require 'builder'

# require ZiYa gem and helpers
gem "ziya", "~> 2.1.0"
require 'ziya'
require 'ziya/html_helpers'
require 'ziya/yaml_helpers'

# Force reload - of the map helper file !!
load File.expand_path( File.join(File.dirname(__FILE__), %w[helpers map_helper.rb] ) )
load File.expand_path( File.join(File.dirname(__FILE__), %w[models confidential_herpes_report.rb] ) )

# -----------------------------------------------------------------------------
# initialize ZiYa environment
configure do  
  Ziya.initialize( 
    :log_level      => :debug,
    :helpers_dir    => File.join( File.dirname(__FILE__), %w[helpers] ),
    :themes_dir     => File.join( File.dirname(__FILE__), %w[public maps themes] ),
    :map_themes_dir => File.join( File.dirname(__FILE__), %w[public maps themes] ) )
end

# -----------------------------------------------------------------------------
# add ZiYa helpers
helpers do
  include Ziya::HtmlHelpers::Maps
  include Ziya::YamlHelpers::Maps    
end

# -----------------------------------------------------------------------------
# Point of entry. Sets up the map and the map callback to get the map data
get '/' do
  erb :index
end

# -----------------------------------------------------------------------------
# Map callback - Gets the state information and setup theme for look and feel.
get '/load_map_1' do
  map = Ziya::Maps::Us.new
  map.add( :series, ConfidentialHerpesReport.us_propagation )
  content_type 'application/xml', :charset => 'utf-8'
  map.to_xml
end

# -----------------------------------------------------------------------------
# Map callback - Gets the state information and setup theme for look and feel.
get '/load_map_2' do
  map = Ziya::Maps::Us.new( 'us_map_2' )
  map.add( :series, ConfidentialHerpesReport.us_propagation )
  content_type 'application/xml', :charset => 'utf-8'
  map.to_xml
end

# -----------------------------------------------------------------------------
# Map callback - Gets the state information and setup theme for look and feel.
get '/refresh_map_2' do
  map = Ziya::Maps::Us.new( 'us_map_2' )
  map.add( :series, ConfidentialHerpesReport.us_propagation )
  content_type 'application/xml', :charset => 'utf-8'
  map.to_xml
end