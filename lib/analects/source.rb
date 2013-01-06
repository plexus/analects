module Analects
  class Source
    attr_reader :options

    def initialize( options = {} )
      @options = options
    end

    def name      ; options[:name]                ; end

    def url       ; options[:url]                 ; end
    def retrieval ; Array(  options[:retrieval] ) ; end

    def data_dir
      File.expand_path( '../../../data', __FILE__ )
    end

    def location 
      options[:data_file] ? File.join( data_dir, options[:data_file] ) : File.join( data_dir, options[:name].to_s )
    end

    def data_file_present?
      File.exist? location
    end

    def retrieve
      retrieve! unless data_file_present?
    end

    def retrieve!
      retrieval.inject( url ) do | result, method | 
        self.send( "retrieve_#{method}", result )
      end
    end

    # url -> stream
    def retrieve_http( url )
      require 'open-uri'
      open( url )
    end

    # gzipped stream -> uncompressed stream
    def retrieve_gunzip( stream )
      require 'zlib'
      Zlib::GzipReader.new( stream )
    end

    # stream|string -> create data file
    def retrieve_save( data )
      File.open( location, 'w' ) do |f|
        f << ( data.respond_to?(:read) ? data.read : data )
      end
    end

    # url -> clones repo
    def retrieve_git( url )
      `git clone #{url} #{data_dir}/#{name}` # Admittedly crude
    end

    def loader
      options[:loader].new( location )
    end

  end
end
