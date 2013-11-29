# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Load do
  
  let(:format){
    %Q{
      # first dataset
      source_code: NSE
      code: OIL
      name: Oil India Limited
      description: |-
        Here is a description with multiple lines.
        This is the second line.
      -
      Date, Value, High, Low
      2013-11-20,9.99470588235294,11.003235294117646,14.00164705882353
      2013-11-19,10.039388096885814,,14.09718770934256
      
      # Second dataset
      code:           DATASET_CODE_2
      source_code:    SOURCE_CODE_2
      name:           Test Dataset Name 2
      description:    Here is a description with multiple lines.
      -
      Date, Value, High, Low
      2013-11-20,9.99470588235294,11.003235294117646,14.00164705882353
      2013-11-19,10.039388096885814,,14.09718770934256
      2013-11-18,11.039388096885814,,15.09718770934256
    }
  }
  
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
      its(:data){ should eq [["2013-11-20", "9.99470588235294", "11.003235294117646", "14.00164705882353"], 
        ["2013-11-19", "10.039388096885814", nil, "14.09718770934256"]] }
    end
  end
  
end