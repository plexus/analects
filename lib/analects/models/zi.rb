module Analects
  module Models
    class Zi
      RANGES = IceNine.deep_freeze(
        unified:
        { name: 'CJK Unified Ideographs',
          range: 0x4E00..0x9FFF, # Ox9FC4..9FFF have no Unihan data
          sort_diff: -0x4E00
        },
        extension_A:
        { name: 'CJK Unified Ideographs Extension A',
          range: 0x3400..0x4DBF, # 0x4DB6..4DBF have no Unihan data
          sort_diff: 0x1E00
        },
        extension_B:
        { name: 'CJK Unified Ideographs Extension B',
          range: 0x20000..0x2A6DF, # 0x2A6D7..2A6DF have no Unihan data
          sort_diff: -0x19400
        },
        compatibility:
        { name: 'CJK Compatibility Ideographs',
          range: 0xF900..0xFAFF, # 0xFADA..FAFF; 0xFA2E..0xFA2F; 0xFA6B..0xFA6F have no Unihan data
          sort_diff: 0xFD00
        },
        supplement:
        { name: 'CJK Compatibility Ideographs Supplement',
          range: 0x2F800..0x2FA1F, # 0x2FA1E..0x2FA1F have no Unihan data
          sort_diff: -0x10000
        },
        radicals_supplement:
        { name: 'CJK Radicals supplement',
          range: 0x2E80..0x2EFF
        },
        kangxi_radicals:
        { name: 'Kangxi Radicals',
          range: 0x2F00..0x2FDF
        }
      )

      def self.codepoint_ranges
        RANGES.values.map { |v| v[:range] }
      end

      # Regexp that matches a single CJK character
      REGEXP = Regexp.union(
        codepoint_ranges.map do |range|
          Regexp.new('[\u{%s}-\u{%s}]' % [range.begin.to_s(16), range.end.to_s(16)])
        end
      )

      ANTIREGEXP = Regexp.new(
        '[^' + codepoint_ranges.map { |range| '\u{%s}-\u{%s}' % [range.begin.to_s(16), range.end.to_s(16)] }.join +
        ']'
      )

      def self.each_radical(&block)
        RANGES[:kangxi_radicals][:range].each do |codepoint|
          block.call([codepoint].pack('U'))
        end
      end
    end
  end
end
