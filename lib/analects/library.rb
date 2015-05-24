module Analects
  CEDICT_URL        = 'http://www.mdbg.net/chindict/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz'
  CHISE_IDS_URL     = 'http://git.chise.org/git/chise/ids.git'
  UNIHAN_URL        = 'http://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip'
  HSK_URL           = 'https://raw.githubusercontent.com/plexus/analects-data/master/hsk/hsk.csv'
  TW_CURRICULUM_URL = 'https://raw.githubusercontent.com/plexus/analects-data/master/taiwan_school_curriculum.txt'
  CJK_DECOMP_URL    = ''

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

    def sources
      [
        cedict,
        chise_ids,
        unihan,
        hsk
      ]
    end

    def cedict
      @cedict ||= create_source(
        :cedict,
        data_file: 'cedict_1_0_ts_utf-8_mdbg.txt',
        retrieval: [ :http, :gunzip, :save ]
      )
    end

    def chise_ids
      @chise_ids ||= create_source(
        :chise_ids,
        retrieval: :git
      )
    end

    def unihan
      @unihan ||= create_source(
        :unihan,
        retrieval: [ :http, :unzip ]
      )
    end

    def hsk
      @hsk ||= create_source(
        :hsk,
        data_file: 'hsk.csv',
        retrieval: [ :http, :save ]
      )
    end

    def cjk_decomp
      @hsk ||= create_source(
        :cjk_decomp,
        data_file: 'cjk-decomp-0.4.0.txt'
      )
    end

    private

    def create_source(name, source_options)
      Source.new(
        source_options.merge(
          {
            name: name,
            library: self,
            url: Analects.const_get("#{name.to_s.upcase}_URL"),
            loader: Analects.const_get("#{Inflecto.camelize name}Loader"),
            data_dir: data_dir
          }
        ).merge(options.fetch(name, {}))
      )
    end

  end
end
