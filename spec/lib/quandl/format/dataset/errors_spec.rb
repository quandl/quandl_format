# encoding: utf-8
require 'spec_helper'

describe Quandl::Format::Dataset do
  expected_errors = [
    { file: 'invalid_data',       error: /Date/ },
    { file: 'unknown_attribute',  error: /this_attribute_does_not_exist/ },
    { file: 'mismatched_columns', error: /column_names had 4 columns/ },
    { file: 'mismatched_rows',    error: /had 3 columns/ },
    { file: 'invalid_yaml',       error: /could not find expected ':'/ },
  ]
  # run each expectation
  expected_errors.each do |pair|
    it "#{pair[:file]}.qdf should error with #{pair[:error]}" do
      Quandl::Logger.should_receive(:error).at_least(:once).with(pair[:error])
      Quandl::Format::Dataset.load( fixtures_data[pair[:file]] )
    end
  end
  
end