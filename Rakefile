require 'rspec/core/rake_task'

$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :coverage do
  ENV['COVERAGE'] = '1'
  Rake::Task['spec'].invoke
end

namespace :analects do
  namespace :retrieve do
    desc 'download CC-CEDICT'
    task :cedict do
      Analects::Sources.cedict.retrieve
    end

    desc 'download Chise-IDS'
    task :chise_ids do
      Analects::Sources.chise_ids.retrieve
    end

    desc 'download all sources'
    task :all => [:cedict, :chise_ids]
  end
end

require 'analects'
