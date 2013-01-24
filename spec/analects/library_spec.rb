require 'spec_helper'

describe Analects::Library do
  it "should take an options hash that specifies the data directory" do
    Analects::Library.new( :data_dir => '/test/123' ).data_dir.should == '/test/123'
  end
end
