module Analects
  class Source
    include Enumerable
    attr_reader :options

    def initialize(options = {})
      @options = options
    end

    def library
      options[:library]
    end

    def name
      options[:name]
    end

    def url
      options[:url]
    end

    def retrieval
      Array(options[:retrieval])
    end

    def loader
      @loader ||= options[:loader].new(Pathname(location), library)
    end

    def data_dir
      Pathname(options[:data_dir])
    end

    def location
      options[:data_file] ?
        data_dir.join(options[:data_file]) :
        data_dir.join(options[:name].to_s)
    end

    def data_file_present?
      location.exist?
    end

    def retrieve
      retrieve! unless data_file_present?
    end

    def retrieve!
      retrieval.inject(url) do |result, method|
        send("retrieve_#{method}", result)
      end
    end

    # url -> stream
    def retrieve_http(url)
      require 'open-uri'
      StringIO.new(open(url).read)
    end

    # gzipped stream -> uncompressed stream
    def retrieve_gunzip(stream)
      require 'zlib'
      Zlib::GzipReader.new(stream)
    end

    def retrieve_unzip(stream)
      require 'zip'
      location.mkdir unless location.exist?
      Zip::InputStream.open(stream) do |io|
        while (entry = io.get_next_entry)
          next if entry.ftype == :symlink
          loc = location.join(entry.name)
          loc.delete if loc.exist?
          entry.extract(loc)
        end
      end
    end

    # stream|string -> create data file
    def retrieve_save(data)
      File.open(location, 'w') do |f|
        f << (data.respond_to?(:read) ? data.read : data)
      end
    end

    # url -> clones repo
    def retrieve_git(url)
      `git clone #{url} #{data_dir}/#{name}` # Admittedly crude
    end

    def each(&block)
      return to_enum unless block_given?
      loader.each(&block)
    end
  end
end
