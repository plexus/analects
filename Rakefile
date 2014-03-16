require 'rspec/core/rake_task'
require 'devtools'

Devtools.init_rake_tasks

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

namespace :ci do
  desc 'Run metrics (except mutant, rubocop) and spec'
  task travis: %w[
    metrics:coverage
    spec:integration
    metrics:yardstick:verify
    metrics:flog
    metrics:flay
  ]
  # metrics:reek
  # metrics:rubocop
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

require 'analects'

Analects.init_rake_tasks

require 'rubygems/tasks'
Gem::Tasks.new
