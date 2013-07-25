# encoding: UTF-8

module Analects
  class CedictLoader
    include Enumerable

    attr_reader :headers

    def initialize(io)
      @contents = io.read
      @headers = {}
      @contents.each_line do |line|
        if line =~ /^#! (.*)=(.*)/
          @headers[$1.strip] = $2.strip
        end
        break unless line =~ /^#/
      end
    end

    def field_names
      [:traditional, :simplified, :pinyin, :definitions]
    end

    def each
      if block_given?
        @contents.each_line do |line|
          yield process_contents(line) if line !~ /^#/
        end
      else
        enum_for(:each)
      end
    end

    private

    def process_contents(line)
      if line.strip =~ /^([^\s]*) ([^\s]*) \[([\w\d:,· ]+)\](.*)/
        [$1,$2,$3,$4].map{|x| x.strip}
      else
        raise "Unexpected contents : #{line.inspect}"
      end
    end
  end
end
