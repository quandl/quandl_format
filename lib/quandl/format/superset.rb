module Quandl
module Format

class Superset < Quandl::Format::Abstract
  
  class << self
    
    protected
    
    def before_call(node)
      Quandl::Client::Superset.new( node.as_json )
    end
     
  end
  
end
end
end