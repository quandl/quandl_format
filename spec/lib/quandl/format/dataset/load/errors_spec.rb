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
  it_should_expect_error 'invalid_yaml',       /Could not find expected ':'/
  it_should_expect_error 'missing_dashes',     /Could not find expected ':' on line 22/
  it_should_expect_error 'missing_dashes',     /Did you forget to delimit the meta data section/
  it_should_expect_error 'missing_colon',     /forget a colon.+code foo/m
  it_should_expect_error 'missing_colon2',     /Could not find expected ':' on line 3/
  it_should_expect_error 'missing_space',     /Are you missing a colon/
  it_should_expect_error 'extra_colon',       /an illegal colon/
  
end