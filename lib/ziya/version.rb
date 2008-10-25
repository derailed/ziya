module Ziya
  module Version
    MAJOR = 2
    MINOR = 0
    TINY  = 8
    
    # Returns the version string for the library.
    def self.version
      [ MAJOR, MINOR, TINY].join( "." )
    end
  end
end


