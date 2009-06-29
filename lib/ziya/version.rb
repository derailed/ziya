module Ziya
  module Version
    MAJOR = 2
    MINOR = 1
    TINY  = 2
    
    # Returns the version string for the library.
    def self.version
      [ MAJOR, MINOR, TINY ].join( "." )
    end
  end
end


