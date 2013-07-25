module Analects
  class ChiseIdsLoader
    include Enumerable

    attr_accessor :only_unicode

    def initialize(io, only_unicode = true)
      @contents = io.read
      @only_unicode = only_unicode
    end

    def field_names
      [:name, :representation, :ids]
    end

    def each(&blk)
      if block_given?
        @contents.each_line do |l|
          next unless l =~ /\t/
          next if only_unicode && l !~ /^U/

          yield l.strip.split("\t")[0..2]
        end
      else
        enum_for(:each)
      end
    end

    # def files
    #   location && (File.directory?(location) ? Dir[File.join(location, 'IDS-*.txt')] : Array(location))
    # end
  end
end
