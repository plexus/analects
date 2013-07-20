require 'tempfile'
require 'spec_helper'
require 'securerandom'

describe Analects::Library do
  subject(:library) {
    described_class.new(options)
  }
  let(:options) { {} }

  context 'with a data_dir specified' do
    let(:data_dir) { File.join(Dir.tmpdir, 'analects-' + SecureRandom.hex(16)) }
    let(:options) {
      { data_dir: data_dir }
    }

    it 'should set that data dir on the sources' do
      subject.cedict.data_dir.should == data_dir
    end
  end

  describe "#cedict" do
    subject(:cedict) { library.cedict }

    its(:name)     { should == :cedict }
    its(:location) { should == File.join(Dir.home, '.analects/cedict_1_0_ts_utf-8_mdbg.txt') }

    it "should download and unpack the CEDICT archive" do
      cedict.should_receive(:retrieve_http).once.with(Analects::CEDICT_URL).and_return(:a_stream)
      cedict.should_receive(:retrieve_gunzip).once.with(:a_stream).and_return(:an_unzipped_stream)

      cedict.retrieve!
    end
  end

  it "should have a CHISE IDS source" do
    library.chise_ids.name.should == :chise_ids
  end

  describe "#chise_ids" do
    subject (:chise_ids) { library.chise_ids }

    its( :name )      { should == :chise_ids }
    its( :retrieval ) { should == [ :git ] }
    its(:location   ) { should == File.join(Dir.home, '.analects/chise_ids') }
    its( :url       ) { should == Analects::CHISE_IDS_URL}
  end


end
