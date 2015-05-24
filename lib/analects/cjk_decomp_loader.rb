# encoding: UTF-8

module Analects
  class CjkDecompLoader
    include Enumerable

    attr_reader :location

    def initialize(location, _library)
      @location = location
    end

    def each
      return to_enum(__method__) unless block_given?
      numize = ->(n) { Integer(n) rescue n }
      @location.each_line do |line|
        char, rest = line.strip.split(':')
        if rest =~ /(.*)\((.*)\)/
          type, parts = Regexp.last_match(1), Regexp.last_match(2).split(',').map(&numize)
          yield [numize[char], type, parts]
        end
      end
    end
  end
end
