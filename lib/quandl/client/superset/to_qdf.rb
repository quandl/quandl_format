module Quandl
module Client
class Superset
  
  def to_qdf
    attributes.stringify_keys.to_hash.to_yaml[4..-1] + "---\n"
  end
  
end
end
end