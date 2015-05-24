# encoding: UTF-8

module Analects
  class CedictLoader
    include Enumerable

    attr_reader :headers

    def initialize(io, _library)
      @contents = io.read
      @headers = {}
      @contents.each_line do |line|
        @headers[Regexp.last_match(1).strip] = Regexp.last_match(2).strip if line =~ /^#! (.*)=(.*)/
        break unless line =~ /^#/
      end
    end

    def field_names
      [:traditional, :simplified, :pinyin, :definitions]
    end

    def each(&blk)
      return to_enum(__method__) unless block_given?
      @entries ||= @contents.each_line.map do |line|
        process_contents(line) if line !~ /^#/
      end.compact
      @entries.each(&blk)
    end

    def find_by(qry)
      qry.map { |field, value| lookup_index(field).fetch(value, []) }.inject { |r1, r2| r1 & r2 }
    end

    def lookup_index(field)
      @indexes ||= field_names.each_with_object({}) do |field, acc|
        acc[field] = each_with_object({}) do |entry, acc|
          (acc[entry[field_names.index(field)]] ||= []) << entry
        end
      end
      @indexes[field]
    end

    private

    def process_contents(line)
      if line.strip =~ /^([^\s]*) ([^\s]*) \[([\w\d:,· ]+)\](.*)/
        [Regexp.last_match(1), Regexp.last_match(2), Regexp.last_match(3), Regexp.last_match(4)].map(&:strip)
      else
        fail "Unexpected contents : #{line.inspect}"
      end
    end
  end
end
