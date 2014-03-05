# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
    
  let(:file_path){ 'spec/fixtures/data/' }
  let(:file){ File.open( File.join(file_path, self.class.superclass.description + '.qdf')) }
  let(:output){
    output = []
    Quandl::Format::Dataset.each_line( file ){|r,e| output << OpenStruct.new( record: r, error: e ) }
    output
  }
  subject{ output.first }
  
  context "unknown_attribute" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /this_attribute_does_not_exist/ }
  end

  context "invalid_yaml" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Could not find expected ':'/ }
  end

  context "illegal_dash" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Could not find expected ':'/ }
  end

  context "missing_dashes" do
    subject{ output[2] }
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Could not find expected ':' on line 22/ }
  end

  context "missing_colon" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Did you forget a colon on this line/ }
  end

  context "missing_colon2" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Could not find expected ':' on line 3/ }
  end

  context "missing_space" do
    its(:record){ should be_nil }
    its("error.to_s"){ should match /Are you missing a colon/ }
  end
 
end