require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :coverage do
  ENV['COVERAGE'] = '1'
  Rake::Task['spec'].invoke
end

require 'analects'
require 'analects/rake_tasks'

Analects::RakeTasks.new
