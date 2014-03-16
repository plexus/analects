require File.expand_path('../lib/analects/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'analects'
  gem.version     = Analects::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Arne Brasseur']
  gem.email       = ['arne.brasseur@gmail.com']
  gem.homepage    = 'https://github.com/arnebrasseur/analects.rb'
  gem.license     = 'GPL-3.0'
  gem.summary     = 'Toolkit for Mandarin language learning apps'
  gem.description = gem.summary

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files -- spec`.split($/)
  gem.extra_rdoc_files = %w[README.md]

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rubygems-tasks'
  gem.add_development_dependency 'pry'

  gem.add_runtime_dependency 'inflecto', '~> 0.0.2'
  gem.add_runtime_dependency 'rmmseg'
  gem.add_runtime_dependency 'ting', '~> 0.9.0'
  gem.add_runtime_dependency 'ice_nine'
end
