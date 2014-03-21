module Quandl
module Client
class Superset
  
  def to_qdf
    out = attributes.stringify_keys.to_hash.to_yaml[4..-1]
    out += Quandl::Format::Superset::Node.syntax[:end_of_node]
    out += "\n"
    out
  end
  
end
end
end