require 'spec_helper'

describe Analects::Sources do
  describe "#cedict" do
    subject( :source ) { Analects::Sources.cedict }

    its( :name )     { should == :cedict }
    its( :location ) { should =~ /\/data\/#{Analects::Sources::CEDICT_FILENAME}$/ }

    it "should download and unpack the CEDICT archive" do
      source.should_receive(:retrieve_http).once.with(Analects::Sources::CEDICT_URL).and_return(:a_stream)
      source.should_receive(:retrieve_gunzip).once.with(:a_stream).and_return(:an_unzipped_stream)

      source.retrieve!
    end
  end

  it "should have a CHISE IDS source" do
    Analects::Sources.chise_ids.name.should == :chise_ids
  end

  describe "#chise_ids" do
    subject ( :source ) { Analects::Sources.chise_ids }

    its( :name )      { should == :chise_ids }
    its( :retrieval ) { should == [ :git ] }
    its( :location  ) { should =~ /\/data\/chise_ids$/}
    its( :url       ) { should == Analects::Sources::CHISE_IDS_URL}
  end

end
