require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "configurator"
    s.summary = %Q{Fatten your models with key/value pairs}
    s.email = "me@brennandunn.com"
    s.homepage = "http://github.com/brennandunn/configurator"
    s.description = "Fatten your models with key/value pairs"
    s.authors = ["Brennan Dunn"]
    s.files = %w(MIT-LICENSE README.rdoc Rakefile) + Dir.glob("{lib,test,generators}/**/*")
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib' << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |t|
    t.libs << 'test'
    t.test_files = FileList['test/**/*_test.rb']
    t.verbose = true
  end
rescue LoadError
  puts "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
end

task :default => :test
