# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
  expected_errors = [
    { file: 'invalid_data',       error: /Date/ },
    { file: 'unknown_attribute',  error: /this_attribute_does_not_exist/ },
    { file: 'mismatched_columns', error: /Expected 4 but found 5/ },
    { file: 'mismatched_rows',    error: /Expected 3 but found 4/ },
    { file: 'invalid_yaml',       error: /could not find expected ':'/ },
    { file: 'missing_dashes',     error: /Attribute parse error at line 28 column 1/ },
    { file: 'missing_dashes',     error: /Did you forget to delimit the meta data section/ },
  ]
  
  # run each expectation
  expected_errors.each do |pair|
    it "#{pair[:file]}.qdf should error with #{pair[:error]}" do
      Quandl::Logger.should_receive(:error).at_least(:once).with(pair[:error])
      Quandl::Format::Dataset.load( fixtures_data[pair[:file]] )
    end
  end
  
end