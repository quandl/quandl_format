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
  its(:data){ should eq Quandl::Data.new([["2013-11-20", "9.99", "11.0", "14.0"], ["2013-11-19", "10.03", nil, "14.09"]]) }
  
  its(:attributes){ should eq attributes }
  
  its(:to_qdf){ should eq qdf_attributes_to_format }
  
end