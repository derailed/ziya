module Ziya
  module Version
    MAJOR = 2
    MINOR = 1
    TINY  = 5
    
    # Returns the version string for the library.
    def self.version
      [ MAJOR, MINOR, TINY ].join( "." )
    end
  end
end


