require 'quandl/client/superset/to_qdf'

module Quandl
module Format

class Superset < Quandl::Format::Abstract

  require 'quandl/format/superset/node'
  
  def self.before_call(node)
    Quandl::Client::Superset.new( node.as_json )
  end

end
end
end