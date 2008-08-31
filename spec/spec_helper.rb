require 'rubygems'
require 'builder'
require 'spec'
require File.join( File.dirname(__FILE__), %w[.. lib ziya] )

# Init ZiYa...
Ziya.initialize( :log_level   => :debug,
                 :themes_dir  => File.join( File.dirname(__FILE__), %w[themes] ),
                 :designs_dir => File.join( File.dirname(__FILE__), %w[designs] ),
                 :helpers_dir => File.join( File.dirname(__FILE__), %w[test_helpers] ) )