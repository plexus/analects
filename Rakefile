require 'rspec/core/rake_task'
require 'devtools'

Devtools.init_rake_tasks

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

require 'analects'

Analects.init_rake_tasks

require 'rubygems/tasks'
Gem::Tasks.new
