require 'pry'
require 'quandl/format'

Quandl::Logger.use Quandl::Logger::Outputs

Quandl::Format::Dataset.load_from_file('spec/fixtures/data/invalid_data.qdf')
Quandl::Format::Dataset.load_from_file('spec/fixtures/data/invalid_yaml.qdf')
Quandl::Format::Dataset.load_from_file('spec/fixtures/data/mismatched_columns.qdf')