begin
  require 'bones'
rescue LoadError
  abort '### Please install the "bones" gem ###'
end

task :default      => 'spec:run'
task 'gem:release' => 'spec:run'

Bones {
  name            'ziya'
  authors         'Fernand Galiana'
  readme_file     'README.rdoc'
  email           'fernand@liquidrail.com'
  url             'http://ziya.liquidrail.com/'
  gem.executables %w[ziyafy]
  spec_opts       %w[--color]
  ruby_opts       %w[-W0]
  
  depends_on "logging"
  depends_on "color"
  depends_on "bones"       , :development => true
  depends_on "bones-git"   , :development => true
  depends_on "bones-extras", :development => true
}