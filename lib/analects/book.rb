module Analects
  class Book
    attr_accessor :opts

    def initialize( opts = {} )
      @opts = opts
    end
  end
end
