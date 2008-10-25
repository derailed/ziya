# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'ziya'      
require 'ziya/version'
                   
task :default => 'spec:run'

PROJ.name           = 'ziya'
PROJ.authors        = 'Fernand Galiana'
PROJ.email          = 'fernand@liquidrail.com'
PROJ.url            = 'http://ziya.rubyforge.org'
PROJ.rubyforge_name = 'ziya'            
PROJ.description    = "Easily add charting to your rails/merb applications"
PROJ.spec_opts      << '--color'
PROJ.rcov_dir       = 'coverage'  
PROJ.rdoc_dir       = 'docs'  
PROJ.ruby_opts      = %w[-W0]
PROJ.version        = ::Ziya::Version.version
PROJ.svn            = 'ziya'
PROJ.rcov_threshold = 90.0
PROJ.executables    = ['ziyafy']

PROJ.exclude        << %w[.DS_Store$ .swo$ .swp$]
PROJ.tests          = FileList['test/**/test_*.rb']   
PROJ.annotation_tags << 'BOZO'

desc "Clean up artifact directories"
task :clean do    
  rcov_artifacts = File.join( File.dirname( __FILE__ ), "coverage" )
  FileUtils.rm_rf rcov_artifacts if File.exists? rcov_artifacts
  rdoc_artifacts = File.join( File.dirname( __FILE__ ), "docs" )
  FileUtils.rm_rf rdoc_artifacts if File.exists? rdoc_artifacts  
  gem_artifacts = File.join( File.dirname( __FILE__ ), "pkg" )
  FileUtils.rm_rf gem_artifacts if File.exists? gem_artifacts    
end  

task 'gem:package' => 'manifest:assert'

depend_on "logging", ">= 0.9.0"
