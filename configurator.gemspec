# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{configurator}
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brennan Dunn"]
  s.date = %q{2009-12-13}
  s.description = %q{Fatten your models with key/value pairs}
  s.email = %q{me@brennandunn.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "generators/config_table/config_table_generator.rb",
     "generators/config_table/templates/migration/create_config_table.rb",
     "lib/configurator.rb",
     "lib/configurator/configuration_hash.rb",
     "lib/configurator/configurator.rb",
     "test/configurator_test.rb",
     "test/helper.rb"
  ]
  s.homepage = %q{http://github.com/brennandunn/configurator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Fatten your models with key/value pairs}
  s.test_files = [
    "test/configurator_test.rb",
     "test/helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

