module Analects

  class Library
    attr_reader :opts

    def initialize( opts = {} )
      @opts = opts
    end

    def data_dir
      opts[:data_dir] || File.expand_path( '../../../data', __FILE__ )
    end

    def cedict
      make_book Analects::Books::Cedict
    end

    def chise_ids_url
      opts[:chise_ids_url] || Analects::CHISE_IDS_URL
    end

    def chise_ids
      Source.new(
        :name      => :chise_ids,
        :url       => chise_ids_url,
        :retrieval => :git,
        :loader    => Analects::ChiseIdsLoader
      )
    end

    private
    
    def make_book( type )
      press.new( opts.merge( :data_dir => data_dir ) )
    end
  end
end
