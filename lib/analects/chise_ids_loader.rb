module Analects
  class ChiseIdsLoader
    include Enumerable

    attr_reader   :location
    attr_accessor :only_unicode

    def initialize( location, only_unicode = true )
      @location     = location
      @only_unicode = only_unicode
    end

    def field_names
      [ :name, :representation, :ids ]
    end

    def each( &blk )
      if block_given?
        files.each do |f|
          File.open(f).lines.each do |l|
            next unless l =~ /\t/
            next if only_unicode && l !~ /^U/
            yield l.strip.split("\t")[0..2]
          end
        end
      else
        enum_for( :each )
      end
    end

    def files
      File.directory?( location ) ? Dir[File.join(location, 'IDS-*.txt')] : Array( location )
    end

    def enum_lines
      files.each do |f|
        File.open(f).lines.each do |l|
          yield l
        end
      end
    end
  end
end
