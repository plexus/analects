module Analects
  class ChiseIdsLoader
    include Enumerable

    attr_accessor :only_unicode

    class MultiFile < Struct.new(:files)
      def each_line(&blk)
        return to_enum(__method__) unless block_given?
        files.each do |file|
          file.each_line(&blk)
        end
        self
      end
    end

    def initialize(pathname, _library, only_unicode = true)
      @contents = MultiFile.new(pathname.children.select { |ch| ch.to_s =~ /IDS-.*\.txt/ })
      @only_unicode = only_unicode
    end

    def field_names
      [:name, :representation, :ids]
    end

    def each(&blk)
      return to_enum(__method__) unless block_given?
      @entries ||= @contents.each_line
                   .reject { |line| line !~ /\t/ || (only_unicode && line !~ /^U/) }
                   .map    { |line| line.strip.split("\t")[0..2] }
      @entries.each(&blk)
    end
  end
end
