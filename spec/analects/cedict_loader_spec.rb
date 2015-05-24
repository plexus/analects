# -*- coding: utf-8 -*-
require 'spec_helper'

describe Analects::CedictLoader do
  let ( :contents) do
    '# CC-CEDICT
# Community maintained free Chinese-English dictionary.
#
#! charset=UTF-8
#! entries=104941
佰 佰 [bai3] /hundred (banker\'s anti-fraud numeral)/
佱 佱 [fa3] /old variant of 法[fa3]/law/
佳 佳 [jia1] /beautiful/fine/good/
'
  end

  let ( :cedict_loader) { Analects::CedictLoader.new(StringIO.new(contents), nil) }

  it 'should parse headers' do
    expect(cedict_loader.headers).to eql('charset' => 'UTF-8', 'entries' => '104941')
  end

  it 'should parse entries' do
    expect(cedict_loader.take(1)).to eql [['佰', '佰', 'bai3', '/hundred (banker\'s anti-fraud numeral)/']]
  end

  it 'can be enumerated multiple times' do
    2.times do
      cedict_loader.each do |x|
        expect(x).to eql ['佰', '佰', 'bai3', '/hundred (banker\'s anti-fraud numeral)/']
        break
      end
    end
  end

  it 'is an enumerable' do
    expect(cedict_loader.count).to be 3
    expect(cedict_loader.to_a).to be_a Array
    cedict_loader.each { |x| expect(x.size).to be 4 }
  end

  if RUBY_VERSION.split('.').take(2).join('.').to_f >= 1.9
    it 'returns an enumerator when each is called without block' do
      expect(cedict_loader.each).to be_a Enumerator
    end
  end
end
