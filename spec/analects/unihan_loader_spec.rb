# -*- coding: utf-8 -*-
require 'spec_helper'

describe Analects::UnihanLoader do
  subject(:loader) { described_class.new(fake_directory_pathname, nil) }
  let(:fake_directory_pathname) do
    Class.new do
      def children
        [self]
      end

      def each_line(&blk)
        ['U+2B7C7	kTotalStrokes	17',
         'U+343C	kRSUnicode	9.4',
         'U+2F9FC	kCompatibilityVariant	U+4AB2'
        ].each(&blk)
      end
    end.new
  end

  describe '#each' do
    it 'should yield once for each entry' do
      expect(subject.count).to eql 3
    end

    it 'should pull out the individual fields' do
      expect(subject.first.values_at(:codepoint, :field, :value)).to eq [0x2B7C7, 'kTotalStrokes', '17']
    end

    it 'should add a character for the codepoint' do
      expect(subject.first[:char]).to eql '𫟇'
    end
  end

  describe 'REGEXP' do
    let(:entry) { "U+2B7C7\tkTotalStrokes\t17\n" }
    let(:matchdata) { entry.match(Analects::UnihanLoader::REGEXP) }

    it 'should match valid lines' do
      expect(entry).to match Analects::UnihanLoader::REGEXP
    end

    it 'should extract the data' do
      expect(matchdata[:codepoint]).to eql '2B7C7'
      expect(matchdata[:field]).to eql 'kTotalStrokes'
      expect(matchdata[:value]).to eql '17'
    end
  end
end
