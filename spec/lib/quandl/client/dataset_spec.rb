# encoding: utf-8
require 'spec_helper'

describe Quandl::Client::Dataset do
  
  let(:attributes) { {
    code:             'DATASET_CODE_2',
    source_code:      'SOURCE_CODE',
    name:             'Test Dataset Name 2',
    description:      "Here is a description with multiple lines.\n This is the second line.",
    column_names:     ['Date', 'Value', 'High', 'Low'],
    private:          false,
    reference_url:    'http://test.com/',
    data:             [["2013-11-20", "9.99470588235294", "11.003235294117646", "14.00164705882353"], 
                      ["2013-11-19", "10.039388096885814", nil, "14.09718770934256"]], 
  }}
  
  subject{ Quandl::Client::Dataset.new( attributes ) }
  
  it{ should respond_to :to_qdf }

  its(:to_qdf){ should eq Quandl::Format::Dataset.new(attributes).to_qdf }
  
end