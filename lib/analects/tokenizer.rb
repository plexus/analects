module Analects
  class Tokenizer
    #ALGO = RMMSeg::Algorithm
    ALGO = RMMSeg::SimpleAlgorithm

    def initialize(chars_dic = '/tmp/chars.dic', words_dic = '/tmp/words.dic')
      unless File.exist?(chars_dic) && File.exist?(words_dic)
        create_dict_from_cedict( chars_dic, words_dic )
      end
      #RMMSeg::Dictionary.dictionaries = [[:chars, chars_dic], [:words, words_dic]]
      RMMSeg::Config.dictionaries = [[chars_dic, true], [words_dic, false]]
    end

    def library
      @library ||= Analects::Library.new
    end

    def cedict( fn = '/tmp/cedict.json' )
      require 'json'
      unless File.exist?( fn )
        library.cedict.retrieve
        File.write( fn, library.cedict.to_a.to_json )
      end
      @cedict ||= JSON.parse IO.read( fn )
    end

    def create_dict_from_cedict(chars_dic, words_dic)
      words = Set.new
      histo = Hash.new(0)

      cedict.each do |c|
        words << c[0]
        words << c[1]
        (c[0] + c[1]).chars.each do |c|
          histo[c] += 1
        end
      end

      File.write(words_dic, words.sort.join("\n"))
      File.write(chars_dic, histo.map {|ch, cnt| "%s %d\n" % [ ch, cnt ]}.join )
    end

    def tokenize( str )
      [].tap do |result|
        ALGO.new( str ).tap do |alg|
          until (tok = alg.next_token).nil?
            result << tok.text.force_encoding('UTF-8')
          end
        end
      end
    end
  end
end
