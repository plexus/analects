# encoding: UTF-8

module Analects
  class CedictLoader
    include Enumerable

    attr_reader :headers

    def initialize( input )
      @input = File.exist?( input ) ? File.open( input ) : input
      @headers = {}
      @input.lines.each do |line|
        if line =~ /^#! (.*)=(.*)/
          @headers[$1.strip] = $2.strip 
        end
        break unless line =~ /^#/
      end
    end

    def field_names
      [ :traditional, :simplified, :pinyin, :definitions ]
    end

    def each
      if block_given?
        @input.lines.each do |line|
          yield process_input(line) if line !~ /^#/
        end
      else
        enum_for(:each)
      end
    end

    private

    def process_input(line)
      if line.strip =~ /^([^\s]*) ([^\s]*) \[([\w\d:,· ]+)\](.*)/
        [$1,$2,$3,$4].map{|x| x.strip}
      else
        raise "Unexpected input : #{line.inspect}"
      end
    end

  end
end
