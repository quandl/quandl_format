# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Attributes do
  
  let(:attributes) { qdf_attributes }
  
  subject{ Quandl::Format::Dataset.new( attributes ) }
  
  it{ should respond_to :valid? }
  it{ should respond_to :upload }

  its(:valid?){ should be_false }
  
  context "without attributes" do
    subject{ Quandl::Format::Dataset.new }
    its(:valid?){ should be_false }
    its(:upload){ should be_false }
  end
  
end