# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
  
  let(:file){ self.class.superclass.description }
  subject{ Quandl::Format::Dataset.load( fixtures_data[file] ).first }
  
  context "invalid_data" do
    before(:each){ subject.valid? }
    its(:valid?){ should be_false }
    its('errors.messages'){ should eq({ data: ["Invalid date segments. Expected yyyy-mm-dd received 'Date'"] }) }
  end
  
  context "invalid_date" do
    before(:each){ subject.valid? }
    its(:valid?){ should be_false }
    
    its('errors.messages'){ should eq({ data: ["Invalid date 'ASDF'"] }) }
    its('client.valid?'){ should be_false }
    its('client.errors.messages'){ should eq({ data: ["Invalid date 'ASDF'"] }) }
    its('client.data.valid?'){ should be_false }
    its('client.data.errors.messages'){ should eq({ data: ["Invalid date 'ASDF'"] }) }
  end
  
end