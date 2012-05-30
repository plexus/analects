lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |spec|
  spec.name        = 'analects'
  spec.version     = '0.1.0'
  spec.platform    = Gem::Platform::RUBY
  spec.authors     = ['Arne Brasseur']
  spec.email       = ['arne.brasseur@gmail.com']
  spec.homepage    = 'https://github.com/arnebrasseur/analects.rb'
  spec.summary     =
  spec.description = 'Open source data sets on Chinese accessible from Ruby'

  spec.require_path = 'lib'
  spec.files        = Dir.glob('**/*.rb') + %w(README.md)
end
