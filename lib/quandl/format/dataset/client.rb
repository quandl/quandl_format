module Quandl
module Format
class Dataset

module Client
  extend ActiveSupport::Concern
  
  def upload
    client.save if valid?
  end
  
  def valid?
    client.valid_with_server?
  end
  
  def client
    @client ||= Quandl::Client::Dataset.new( attributes )
  end
  def client=(value)
    raise ArgumentError, "Expected Quandl::Client::Dataset received #{value.class}" unless value.is_a?(Quandl::Client::Dataset)
    @client = value
  end
  
end

end
end
end