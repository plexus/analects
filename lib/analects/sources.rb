require 'analects/source'
require 'analects/cedict_loader'
require 'analects/chise_ids_loader'

module Analects
  module Sources
    extend self

    CEDICT_URL      = 'http://www.mdbg.net/chindict/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz'
    CEDICT_FILENAME = 'cedict_1_0_ts_utf-8_mdbg.txt'
    CHISE_IDS_URL   = 'http://git.chise.org/git/chise/ids.git'

    def cedict
      Source.new(
        :name      => :cedict,
        :url       => ( ENV['CEDICT'] || CEDICT_URL ),
        :data_file => CEDICT_FILENAME,
        :retrieval => [ :http, :gunzip, :save ],
        :loader    => Analects::CedictLoader
      )
    end

    def chise_ids
      Source.new(
        :name      => :chise_ids,
        :url       => ( ENV['CHISE_IDS'] || CHISE_IDS_URL ),
        :retrieval => :git,
        :loader    => Analects::ChiseIdsLoader
      )
    end
  end
end
