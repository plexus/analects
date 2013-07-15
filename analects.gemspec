lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'analects/version'

Gem::Specification.new do |spec|
  spec.name        = 'analects'
  spec.version     = Analects::VERSION
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Arne Brasseur']
  spec.email       = ['arne.brasseur@gmail.com']
  spec.homepage    = 'https://github.com/arnebrasseur/analects.rb'
  spec.summary     =
  spec.description = 'Open source data sets on Chinese accessible from Ruby'

  spec.add_development_dependency('rspec')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('rake')

  spec.add_runtime_dependency('active_support')

  spec.require_path = 'lib'
  spec.files        = Dir.glob('**/*.rb') + %w(README.md)
end
