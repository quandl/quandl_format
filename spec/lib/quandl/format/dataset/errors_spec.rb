# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
  subject{ data }
  context "valid.qdf" do
    let(:data){ Quandl::Format::Dataset.load( fixtures_data['valid'] ) }
    
    it{ should be_a Array }
    its(:count){ should eq 3 }
    
    describe "#first" do
      subject{ data.first }
      its(:code){ should eq 'BLAKE_TEST_1' }
      its(:name){ should eq 'A new title' }
      its(:description){ should eq 'The description Date, Open, High'}
      its(:column_names){ should eq ['Date','Open','High','Low','Last','Close','Total Trade Quantity','Turnover (Lacs)']}
      its(:data){ should eq Quandl::Data.new([['2013-11-22','1252.0','454.95','448.2','450.0','450.0','1354405.0','6099.41'],['2013-11-21','452.25','457.75','449.1','451.2','451.0','218881.0','992.94']]) }
    end
  end

  expected_errors = [
    { file: 'invalid_data',       error: /Date/ },
    { file: 'unknown_attribute',  error: /this_attribute_does_not_exist/ },
    { file: 'mismatched_columns', error: /column_names had 4 columns/ },
    { file: 'mismatched_rows',    error: /had 3 columns/ },
    { file: 'invalid_yaml',       error: /could not find expected ':'/ },
  ]
  # run each expectation
  expected_errors.each do |pair|
    it "#{pair[:file]}.qdf should error with #{pair[:error]}" do
      Quandl::Logger.should_receive(:error).at_least(:once).with(pair[:error])
      Quandl::Format::Dataset.load( fixtures_data[pair[:file]] )
    end
  end
  
end