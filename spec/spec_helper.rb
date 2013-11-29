if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

Dir.glob( File.join( File.dirname(__FILE__), 'fixtures/**/*.rb' ) ).each{|f| require(f) }
$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "rspec"
require "quandl/format"
require "config/client"
require 'pry'