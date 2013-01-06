require 'spec_helper'

describe Analects::Source do
  let( :url    ) { 'a_url' }
  let( :source ) { Analects::Source.new( :retrieval => [ :step1, :step2, :step3 ], :url => url ) }

  it "should do retrieve by pipelining the retrieve methods" do
    source.should_receive(:retrieve_step1).with(url).once.and_return(:intermediary_result_1)
    source.should_receive(:retrieve_step2).with(:intermediary_result_1).once.and_return(:intermediary_result_2)
    source.should_receive(:retrieve_step3).with(:intermediary_result_2).once.and_return(:result)
    source.retrieve!
  end

  it "should accept both arrays or single values as retrieval methods" do
    Analects::Source.new( :retrieval =>   :step1   ).retrieval.should == [ :step1 ]
    Analects::Source.new( :retrieval => [ :step1 ] ).retrieval.should == [ :step1 ]
  end
end
