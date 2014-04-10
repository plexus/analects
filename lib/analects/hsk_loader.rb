# encoding: UTF-8

module Analects
  class HskLoader
    extend Forwardable
    include Enumerable

    FIELDS = [:level, :simplified, :traditional, :pinyin]

    class HskEntry < Struct.new(:library, *FIELDS)
      def cedict
        @cedict ||= library.cedict.loader.find_by(
          traditional: traditional,
          simplified: simplified,
        )
      end
    end

    def_delegators :@contents, :each

    def initialize(io, library)
      @contents = CSV(io.read).map do |level, simplified, traditional, pinyin|
        HskEntry.new(library, level, simplified, traditional, pinyin)
      end
    end
  end
end
