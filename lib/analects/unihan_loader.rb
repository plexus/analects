# encoding: UTF-8

module Analects
  class UnihanLoader
    include Enumerable

    attr_reader :location

    def initialize(location, library)
      @location = location
    end

    REGEXP = %r{U\+(?<codepoint>[0-9A-F]+)  # U+2B7C7
                \t
                (?<field>k[^\t]+)          # kTotalStrokes
                \t
                (?<value>.*)}x              # 17

    def each
      return to_enum(__method__) unless block_given?
      files.each do |file|
        file.each_line do |line|
          next unless matchdata = line.match(REGEXP)
          yield(
            :codepoint => matchdata[:codepoint].hex,
            :char => [matchdata[:codepoint].hex].pack('U'),
            :field => matchdata[:field],
            :value => matchdata[:value]
          )
        end
      end
    end

    def files
      @location.children
    end
  end
end
