# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Load do
  
  let(:format){ qdf_format }
  
  describe "junk" do
    let(:collection){ Quandl::Format::Dataset::Load.string('asdf') }
    subject{ collection }
    its(:count){ should eq 1 }
  end
  
  describe ".file" do
    subject{ Quandl::Format::Dataset::Load.file("spec/fixtures/data/valid.qdf") }
    its(:count){ should eq 3 }
  end
  
  describe ".string" do
    
    let(:collection){ Quandl::Format::Dataset::Load.string(format) }
    subject{ collection }
    
    its(:count){ should eq 2 }
    
    describe "#first" do
      subject{ collection.first }

      it{ should be_a Quandl::Format::Dataset }
      its(:source_code){ should eq 'NSE' }
      its(:code){ should eq 'OIL' }
      its(:name){ should eq 'Oil India Limited' }
      its(:description){ should eq "Here is a description with multiple lines.\nThis is the second line." }
      its(:column_names){ should eq ['Date', 'Value', 'High', 'Low'] }
      its(:data){ should eq Quandl::Data.new([["2013-11-20", "9.99", "11.0", "14.0"],["2013-11-19", "10.03", nil, "14.09"]]) }
    end
  end
  
end