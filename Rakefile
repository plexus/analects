require 'rspec/core/rake_task'
require 'devtools'
require 'rubygems/tasks'
require 'rubygems/package_task'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'analects'

Devtools.init_rake_tasks
Analects.init_rake_tasks

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

Gem::Tasks.new

spec = Gem::Specification.load(File.expand_path('../analects.gemspec', __FILE__))
gem = Gem::PackageTask.new(spec)
gem.define

desc "Push gem to rubygems.org"
task :push => :gem do
  sh "git tag v#{Analects::VERSION}"
  sh "git push --tags"
  sh "gem push pkg/analects-#{Analects::VERSION}.gem"
end
