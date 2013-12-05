if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

Dir.glob( File.join( File.dirname(__FILE__), 'fixtures/**/*.rb' ) ).each{|f| require(f) }
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require "quandl/format"
require "config/client"
require "config/logger"
require 'pry'

# Replace Quandl::Logger with Spec::Logger that will raise errors sent to #error
# This allows us to easily test error assertions in spec/lib/quandl/format/errors_spec.rb
Quandl::Logger.use(Quandl::Logger::Outputs)
