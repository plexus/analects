# -*- coding: utf-8 -*-
require 'spec_helper'

describe Analects::ChiseIdsLoader do
  subject(:loader) do
    Analects::ChiseIdsLoader.new(Analects::ROOT.join('spec/test_data/chise_ids'), only_unicode)
  end

  let(:only_unicode) { false }
  let(:entries) { loader.each.to_a }

  describe '#field_names' do
    it 'should return names for the fields in an IDS record' do
      expect(loader.field_names).to eq([:name, :representation, :ids])
    end
  end

  context 'with a loader that only returns data for unicode characters' do
    let(:only_unicode) { true }

    it 'should still return the unicode entries' do
      expect(entries.first).to eq(['U+4E0D', '不', '不'])
    end

    it 'should filter out the non-unicode entries' do
      entries.each do |entry|
        expect(entry.first).to match /^U\+[0-9A-F]{4}/
      end
    end
  end

  describe '#each' do
    it 'should return an enumerator when no block is given' do
      expect(loader.each).to be_instance_of(Enumerator)
    end

    it 'should loop over all entries' do
      expect(entries.first).to eq(['U+4E0D', '不', '不'])
      expect(entries.last).to  eq(['CB00003', '&CB00003;', '⿱㓛&GT-47348;'])
    end

    it 'should filter out entries without a tab' do
      entry_no_tab = entries.detect do |entry|
        entry.join(' ') =~ /Entry without a tab/
      end
      expect(entry_no_tab).to be_nil
    end
  end

end
