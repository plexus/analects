module Analects
  class ChiseIdsLoader
    include Enumerable

    attr_reader   :location
    attr_accessor :only_unicode

    def initialize(location_or_contents, only_unicode = true)
      if location_or_contents =~ /\n/
        @contents = location_or_contents.each_line.to_a
      else
        @location = location_or_contents
        @contents = nil
      end

      @only_unicode = only_unicode
    end

    def field_names
      [:name, :representation, :ids]
    end

    def each(&blk)
      if block_given?
        enum_lines do |l|
          next unless l =~ /\t/
          next if only_unicode && l !~ /^U/
          yield l.strip.split("\t")[0..2]
        end
      else
        enum_for(:each)
      end
    end

    def files
      location && (File.directory?(location) ? Dir[File.join(location, 'IDS-*.txt')] : Array(location))
    end

    def enum_lines(&blk)
      @contents ||= files.flat_map do |f|
        File.open(f).each_line.to_a
      end
      @contents.each do |l|
        next if l =~ /^#/
        yield l
      end
    end
  end
end
