module Quandl
module Format
class Dataset

module Client
  extend ActiveSupport::Concern
  
  def human_errors
    m = "#{full_url} #{client.status}\n"
    m += "  errors: \n"
    m += errors.collect do |error_type, messages|
      messages.collect do |name, message|
        "    #{name}: #{message.join(', ')}\n "
      end
    end.flatten.compact.join
  end
  
  def upload
    client.save if valid?
  end
  
  def valid?
    client.valid_with_server?
  end
  
  def errors
    client.error_messages
  end
  
  def client
    @client ||= Quandl::Client::Dataset.find(full_code) || Quandl::Client::Dataset.new( attributes )
  end
  def client=(value)
    raise ArgumentError, "Expected Quandl::Client::Dataset received #{value.class}" unless value.is_a?(Quandl::Client::Dataset)
    @client = value
  end
  
end

end
end
end