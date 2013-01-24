# -*- coding: utf-8 -*-
describe Analects::ChiseIdsLoader do
  let(:contents) {
'# -*- coding: utf-8 -*-
U+4E0D	不	不
U+4E0E	与	⿹&CDP-8BBF;一
U+4E12	丒	⿱刃一
U+4E15	丕	⿱不一
U+4E19	丙	⿱一内
CB00001	&I-CB00001;	⿰𠤕欠
CB00002	&CB00002;	⿰⿱匕示頁
CB00003	&CB00003;	⿱㓛&GT-47348;'
  }

  let ( :loader ) { Analects::ChiseIdsLoader.new( contents ) }
  let ( :non_unicode_loader )  { Analects::ChiseIdsLoader.new( contents, false ) }

  it "should skip lines starting with #" do
    loader.enum_lines do |l|
      l.should_not =~ /^#/
      break
    end
  end

  it "should skip non-unicode by default" do
    entries = loader.to_a
    entries.first.first.should == "U+4E0D"
    entries.last.first.should  == "U+4E19"
  end

end
