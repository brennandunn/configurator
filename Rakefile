require 'rubygems'
require 'bundler/gem_tasks'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new do |t|
  t.libs = ["lib"]
  t.warning = true
  t.verbose = true
  t.test_files = FileList['**/test/*_test.rb']
end

task :coverage do
  ENV['COVERAGE'] = true
  Rake::Task["spec"].execute
end

task :default => :test
