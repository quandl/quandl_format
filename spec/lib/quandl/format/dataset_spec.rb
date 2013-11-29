# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
  
  let(:attributes) { qdf_attributes }
  
  subject{ Quandl::Format::Dataset.new(attributes) }
  
  its(:code){ should eq 'DATASET_CODE_2' }
  its(:source_code){ should eq 'SOURCE_CODE' }
  its(:name){ should eq 'Test Dataset Name 2' }
  its(:description){ should eq "Here is a description with multiple lines.\n This is the second line." }
  its(:column_names){ should eq ['Date', 'Value', 'High', 'Low'] }
  its(:data){ should eq Quandl::Data.new([["2013-11-20", "9.99470588235294", "11.003235294117646", "14.00164705882353"], ["2013-11-19", "10.039388096885814", nil, "14.09718770934256"]]) }
  
  its(:attributes){ should eq attributes }
  
  its(:to_qdf){ should eq qdf_attributes_to_format }
  
end