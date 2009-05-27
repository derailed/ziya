module Ziya::YamlHelpers::Maps
  include Ziya::YamlHelpers::Base

  # Defines various helpers to assist in writing ZiYa yaml stylesheets.
      
  def map( class_name )
    "--- #{clazz( class_name, :Maps )}"
  end

  def config( component_name )
    "#{component_name}: #{clazz component_name, 'Maps::Support'}"
  end
  
  def level
    "- " + config( :range )
  end
end