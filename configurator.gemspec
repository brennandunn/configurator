Gem::Specification.new do |gem|
  gem.name = %q{ar-configurator}
  gem.version = "1.2.0"

  gem.required_rubygems_version = Gem::Requirement.new(">= 0") if gem.respond_to? :required_rubygems_version=
  gem.authors = ["Brennan Dunn", "Andrew Newman"]
  gem.date = %q{2012-08-12}
  gem.description = %q{Fatten your models with key/value pairs}
  gem.email = %q{andrew.newman@sdx.com.au}
  gem.extra_rdoc_files = [
    "README.rdoc"
  ]

  gem.files = Dir["{lib,generators,test}/**/*.rb"] + ['Gemfile','Rakefile','README.rdoc', 'MIT-LICENSE']
  gem.homepage = %q{http://github.com/newmana/configurator}
  gem.rdoc_options = ["--charset=UTF-8"]
  gem.require_paths = ["lib"]
  gem.rubygems_version = %q{1.3.5}
  gem.summary = %q{Fatten your models with key/value pairs}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency 'activerecord', '>= 3.0.0'
  gem.add_dependency 'activesupport', '>= 3.0.0'

  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'appraisal'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake'
end

