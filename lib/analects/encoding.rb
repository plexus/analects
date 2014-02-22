# -*- coding: utf-8 -*-

module Analects
  module Encoding
    extend self

    GB   = ::Encoding::GB18030
    BIG5 = ::Encoding::BIG5_UAO

    def recode(enc, str)
      str.force_encoding(enc).encode('UTF-8')
    end

    def from_gb(str)
      recode(GB, str)
    end

    def from_big5(str)
      recode(BIG5, str)
    end

    def valid_cjk(str)
      [GB, BIG5].map do |enc|
        begin
          recode(enc, str)
          enc
        rescue ::Encoding::UndefinedConversionError
        rescue ::Encoding::InvalidByteSequenceError
        end
      end.compact
    end

    # Crude way to guess which encoding it is
    def ratings(str)
      all_valid_cjk(str).map do |enc|
        [
          enc,
          recode(enc, str).codepoints.map do |point|
            Analects::Models::Zi.codepoint_ranges.map.with_index do |range, idx|
              next 6-idx if range.include?(point)
              0
            end.inject(:+)
          end.inject(:+)
        ]
      end.sort_by(&:last).reverse
    end

  end
end

# For info on Taiwanese Big5 variants + Ruby
# * https://bugs.ruby-lang.org/issues/1784
# * http://lists.gnu.org/archive/html/bug-gnu-libiconv/2010-11/msg00007.html

# Wikipedia pages of GB (国家标准) encodings (chronological?)
# * http://en.wikipedia.org/wiki/GB_2312
# * http://en.wikipedia.org/wiki/GBK
# * http://en.wikipedia.org/wiki/GB18030

# Ruby also knows about this one, but can't convert it to UTF-8
# * http://en.wikipedia.org/wiki/Extended_Unix_Code#EUC-TW
