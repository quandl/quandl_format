# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do

  def self.it_should_expect_error(file, error)
    it "#{file}.qdf should error with #{error}" do
      Quandl::Logger.should_receive(:error).at_least(:once).with(error)
      Quandl::Format::Dataset.load( fixtures_data[file] )
    end
  end
  
  it_should_expect_error 'invalid_data',       /Date/
  it_should_expect_error 'unknown_attribute',  /this_attribute_does_not_exist/
  it_should_expect_error 'mismatched_columns', /Expected 4 but found 5/
  it_should_expect_error 'mismatched_rows',    /Expected 3 but found 4/
  it_should_expect_error 'invalid_yaml',       /could not find expected ':'/
  it_should_expect_error 'missing_dashes',     /Attribute parse error at line 28 column 1/
  it_should_expect_error 'missing_dashes',     /Did you forget to delimit the meta data section/
  
end