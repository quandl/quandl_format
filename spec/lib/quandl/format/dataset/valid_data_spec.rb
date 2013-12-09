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
  
  context "annual.qdf" do
    let(:data){ Quandl::Format::Dataset.load( fixtures_data['annual'] ) }
    
    it{ should be_a Array }
    its(:count){ should eq 1 }
    
    describe "#first" do
      subject{ data.first }
      its(:code){ should eq 'ANNUAL_DATA' }
      its(:name){ should eq 'A new title' }
      its(:description){ should eq 'Annual Data'}
      its(:column_names){ should eq ['Date','Open','High']}
      its(:data){ should eq [
        [ Date.parse('2013-12-31'), 1252.0, 454.95 ],
        [ Date.parse('2012-12-31'), 452.25, 457.75 ],
        [ Date.parse('2011-12-31'), 452.25, 457.75 ],
        [ Date.parse('2010-12-31'), 452.25, 457.75 ],
      ]}
    end
  end
  
end