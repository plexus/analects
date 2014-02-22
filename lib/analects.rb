require 'tmpdir'

require 'active_support/core_ext/string/inflections'
require 'ice_nine'
require 'rmmseg'

module Analects
  def self.init_rake_tasks(*args, &blk)
    require 'analects/rake_tasks'
    Analects::RakeTasks.new(*args, &blk)
  end

  def self.cjk?(str)
    str.codepoints.all? do |cp|
      Analects::Models::Zi.codepoint_ranges.any? {|range| range.include?(cp)}
    end
  end
end

require 'analects/version'
require 'analects/encoding'
require 'analects/cli/progress'
require 'analects/cedict_loader'
require 'analects/chise_ids_loader'
require 'analects/source'
require 'analects/library'
require 'analects/tokenizer'

require 'analects/models/zi'
require 'analects/models/kangxi_radical'
