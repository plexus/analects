module Analects
  class CedictLoader
    include Enumerable
    attr_reader :headers

    URL = ENV['CEDICT'] || 'http://www.mdbg.net/chindict/export/cedict/cedict_1_0_ts_utf-8_mdbg.txt.gz'
    LOCAL = File.join(File.dirname(__FILE__), '../../data/cedict_1_0_ts_utf-8_mdbg.txt')

    def self.download!
      require 'zlib'
      require 'open-uri'
      File.open(LOCAL,'w') do |f|
        f << Zlib::GzipReader.new(open(URL)).read
      end
    end

    def initialize(input = nil)
      @input = input
      @headers = {}
      @input.lines.each do |line|
        if line =~ /^#! (.*)=(.*)/
          @headers[$1.strip] = $2.strip 
        end
        break unless line =~ /^#/
      end
    end
    
    def process_input(line)
      if line.strip =~ /^([^\s]*) ([^\s]*) \[([\w\d: ]+)\](.*)/
        [$1,$2,$3,$4].map{|x| x.strip}
      else
        line
      end
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
  end
end
