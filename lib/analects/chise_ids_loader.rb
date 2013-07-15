module Analects
  class ChiseIdsLoader
    include Enumerable

    attr_reader   :location
    attr_accessor :only_unicode

    def initialize(location_or_contents, only_unicode = true)
      if location_or_contents =~ /\n/
        @contents = location_or_contents
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
      if @contents
        @contents.lines.each do |l|
          next if l =~ /^#/
          yield l
        end
      else
        files.each do |f|
          File.open(f).lines.each do |l|
            next if l =~ /^#/
            yield l
          end
        end
      end
    end
  end
end
