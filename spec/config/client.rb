require 'ostruct'
require 'yaml'

module Spec
module Config
  Quandl = OpenStruct.new(YAML.load(File.read(File.join(ENV['HOME'], '.quandl/test')))) unless Gem.win_platform?
end
end

require "quandl/client"
require "quandl/fabricate"

unless Gem.win_platform?
  include Quandl::Client
  Quandl::Client.token = Spec::Config::Quandl.token
  Quandl::Client.use( Spec::Config::Quandl.quandl_url )
end