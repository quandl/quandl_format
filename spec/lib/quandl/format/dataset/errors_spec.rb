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
  
  context "invalid_data.qdf" do
    let(:data){ Quandl::Format::Dataset.load( fixtures_data['invalid_data'] ) }
    it{ expect{data}.to raise_error Quandl::Operation::Errors::UnknownDateFormat, /Date/ }
  end
  
  context "unknown_attribute.qdf" do
    let(:data){ Quandl::Format::Dataset.load( fixtures_data['unknown_attribute'] ) }
    it{ expect{data}.to raise_error Quandl::Format::Errors::UnknownAttribute, /this_attribute_does_not_exist/ }
  end
  
end