# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Attributes do
  
  let(:attributes) { qdf_attributes }
  
  subject{ Quandl::Format::Dataset.new( attributes ) }
  
end