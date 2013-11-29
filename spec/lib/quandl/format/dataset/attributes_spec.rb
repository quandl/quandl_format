# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Attributes do
  
  let(:attributes) { qdf_attributes }
  
  subject{ Quandl::Format::Dataset.new( attributes ) }
  
  its(:full_url){ should eq "http://localhost:3000/api/v2/SOURCE_CODE/DATASET_CODE_2" }
  
end