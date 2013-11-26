require 'quandl/logger'

require "quandl/format/version"

require 'csv'

require 'quandl/operation'

require "active_support"
require "active_support/inflector"
require "active_support/core_ext/hash"
require "active_support/core_ext/object"

require 'quandl/format/dump'
require 'quandl/format/load'
require 'quandl/format/node'

module Quandl
  module Format
    
    class << self
    
      def load(input)
        Quandl::Format::Load.from_string(input)
      end
    
      def load_file(file_path)
        Quandl::Format::Load.from_file(file_path)
      end
    
      def dump(nodes)
        Quandl::Format::Dump.nodes(nodes)
      end
    
    end
    
  end
end