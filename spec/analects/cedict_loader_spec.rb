# -*- coding: utf-8 -*-
require 'spec_helper'

describe Analects::CedictLoader do
  let ( :contents ) do
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

  let ( :cedict_loader ) { Analects::CedictLoader.new( contents ) }

  it "should parse headers" do
    cedict_loader.headers.should == { 'charset' => 'UTF-8', 'entries' => '104941' }
  end

  it "should parse entries" do
    cedict_loader.take(1).should == [ ['佰', '佰', 'bai3', '/hundred (banker\'s anti-fraud numeral)/' ] ]
  end

  it "can be enumerated multiple times" do
    2.times do
      cedict_loader.each do |x|
        x.should == ['佰', '佰', 'bai3', '/hundred (banker\'s anti-fraud numeral)/' ]
        break;
      end
    end
  end

  it "is an enumerable" do
    cedict_loader.count.should === 3
    cedict_loader.to_a.should be_instance_of( Array )
    cedict_loader.map {|x| x.size.should === 4 }
  end

  it "returns an enumerator when each is called without block" do
    cedict_loader.each.is_a? Enumerator
  end

end
