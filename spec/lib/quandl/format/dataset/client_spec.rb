# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset::Client do
  
  context "without attributes" do
    subject{ Quandl::Format::Dataset.new }
    its(:valid?){ should be_false }
    its(:upload){ should be_false }
  end
  
  let(:attributes) { qdf_attributes }
  let(:dataset){ Quandl::Format::Dataset.new( attributes ) }
  subject{ dataset }
  
  it{ should respond_to :valid? }
  it{ should respond_to :upload }
  
  context "valid?" do
    before(:each){ subject.valid? }
    its('errors.messages'){ should eq({}) }
  end
  
  its(:valid?){ should be_true }

  its(:client){ should be_a Quandl::Client::Dataset }
  
  ["string", 10, Date.today, [1,2,3], {hash: 'test'} ].each do |value|
    it "#client= #{value.class} should raise_error ArgumentError" do
      expect{ subject.client = value }.to raise_error ArgumentError
    end
  end
  
  it "#client= Quandl::Client::Dataset should return client" do
    d = Quandl::Client::Dataset.new
    subject.client = d
    subject.client.should eq d
  end
  
end