require 'active_support/core_ext/string/inflections'
require 'tmpdir'

module Analects
  def self.init_rake_tasks(*args, &blk)
    require 'analects/rake_tasks'
    Analects::RakeTasks.new(*args, &blk)
  end
end

require 'analects/version'
require 'analects/cli/progress'
require 'analects/cedict_loader'
require 'analects/chise_ids_loader'
require 'analects/source'
require 'analects/library'
