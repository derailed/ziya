# $Id$

# BOZO !! Document !!

# Equivalent to a header guard in C/C++
# Used to prevent the class/module from being loaded more than once
unless defined? Ziya
  module Ziya          
    # :stopdoc:
    LIBPATH = ::File.expand_path(::File.dirname(__FILE__)) + ::File::SEPARATOR
    PATH    = ::File.dirname(LIBPATH) + ::File::SEPARATOR
               
    def self.default_configuration
      { :themes_dir => File.join( File.dirname(__FILE__), %w[.. charts themes] ),
        :log_file   => $stdout,
        :log_level  => :info }
    end
                            
    def self.initialize( opts={} )
      puts ">>> No logger specified. Using ZiYa default logger" unless opts[:logger]
      puts ">>> No themes_dir specified. Using ZiYa default themes" unless opts[:themes_dir]      
      @config = default_configuration.merge( opts )
      @logger = opts[:logger] if opts[:logger]

      # Verify existance of themes, designs and helper dirs if any
      if themes_dir
        raise "Unable to find themes directory `#{themes_dir}" unless File.exists?( themes_dir )
      end

      if designs_dir
        raise "Unable to find designs directory `#{designs_dir}" unless File.exists?( designs_dir )
      end
      
      if helpers_dir
        raise "Unable to find helper directory `#{helpers_dir}" unless File.exists?( helpers_dir )
      end
      
      # Add the ziya/lib to the ruby path...
      $: << libpath
      Ziya.require_all_libs_relative_to __FILE__
      
      dump if config[:log_level] == :debug
    end

    # ZiYa configuration
    def self.config
      @config
    end
          
    # directory location for ziya stylesheet custom helpers
    def self.helpers_dir
      config[:helpers_dir]
    end
    
    # the themes root directory location
    def self.themes_dir
      config[:themes_dir]
    end

    # the gauges designs root directory location
    def self.designs_dir
      config[:designs_dir]
    end
    
    # Debug                        
    def self.dump #:nodoc:
      puts "" 
      puts "ZiYa Configuration Landscape"    
      config.keys.sort{ |a,b| a.to_s <=> b.to_s }.each do |k| 
        key   = k.to_s.rjust(20)
        value = config[k].to_s.rjust(97,".")
        puts "#{key} : #{value}"
      end
    end
    
    # fetch the framework logger        
    def self.logger
      # get a hold of a logger.
      @logger ||= ::Ziya::Logger.new( { :log_file          => config[:log_file], 
                                        :logger_name       => "ZiYa",
                                        :log_level         => config[:log_level],
                                        :additive          => false } )
    end
           
    # Returns the library path for the module. If any arguments are given,
    # they will be joined to the end of the libray path using
    # <tt>File.join</tt>.
    #
    def self.libpath( *args ) #:nodoc:
      args.empty? ? LIBPATH : ::File.join(LIBPATH, *args)
    end

    # Returns the lpath for the module. If any arguments are given,
    # they will be joined to the end of the path using
    # <tt>File.join</tt>.
    #
    def self.path( *args ) #:nodoc:
      args.empty? ? PATH : ::File.join(PATH, *args)
    end

    # Utility method used to require all files ending in .rb that lie in the
    # directory below this file that has the same name as the filename passed
    # in. Optionally, a specific _directory_ name can be passed in such that
    # the _filename_ does not have to be equivalent to the directory.
    #
    def self.require_all_libs_relative_to( fname, dir = nil ) #:nodoc:
      dir       ||= ::File.basename(fname, '.*')
      search_me   = ::File.expand_path( ::File.join(::File.dirname(fname), dir, '**', '*.rb'))
      Dir.glob(search_me).sort.each {|rb| require rb}
    end 
  end
end