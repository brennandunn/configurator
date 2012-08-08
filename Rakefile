require 'bundler/gem_tasks'
require 'appraisal'
require 'rake'
require 'rake/testtask'
require 'rdoc/task'

Bundler::GemHelper.install_tasks

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
