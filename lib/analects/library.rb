module Analects
  CEDICT_URL      = 'http://www.mdbg.net/chindict/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz'
  CHISE_IDS_URL   = 'http://git.chise.org/git/chise/ids.git'

  class Library
    attr_reader :options

    def initialize(options = {})
      @options = options.freeze
    end

    def data_dir
      if options[:data_dir]
        Dir.mkdir(options[:data_dir]) unless File.exist?(options[:data_dir])
        return options[:data_dir]
      end
      File.join(Dir.home, '.analects').tap do |dir|
        unless File.exist? dir
          Dir.mkdir dir
        end
      end
    end

    def cedict
      Source.new(
        {
          data_file: 'cedict_1_0_ts_utf-8_mdbg.txt',
          retrieval: [ :http, :gunzip, :save ]
        }.merge(options_for :cedict)
      )
    end

    def chise_ids
      Source.new({retrieval: :git}.merge(options_for :chise_ids))
    end

    private

    def options_for(name)
      {
        name: name,
        url: Analects.const_get("#{name.to_s.upcase}_URL"),
        loader: Analects.const_get("#{name.to_s.camelize}Loader"),
        data_dir: data_dir
      }.merge(options.fetch(name, {}))
    end


  end
end
