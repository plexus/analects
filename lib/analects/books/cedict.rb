module Analects
  module Books
    class Cedict < Analects::Book
      def cedict_url
        opts[:cedict_url] || Analects::URL::CEDICT
      end

      def cedict_filename
        opts[:cedict_filename] || Analects::URL::CEDICT.gsub(%r{.*/(.*)\.gz}, '\1')
      end

      def source
        Source.new(
          :name      => :cedict,
          :url       => cedict_url
          :data_file => cedict_filename,
          :retrieval => [ :http, :gunzip, :save ],
        )
      end

      def loader
        Analects::CedictLoader.new( source.location )
      end
    end
  end
end
