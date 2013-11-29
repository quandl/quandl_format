module Quandl
module Format
class Dataset

module Client
  extend ActiveSupport::Concern
  
  def human_errors
    return if errors.blank?
    puts errors
    m = "#{client.full_url} #{client.status}\n"
    m += "  errors: \n"
    m += errors.collect do |error_type, messages|
      next human_error(error_type, messages)  unless messages.is_a?(Hash)
      messages.collect{|n,m| human_error(n, m) }
    end.flatten.compact.join
  end
  
  def human_error(name, message)
    message = message.join(', ') if message.respond_to?(:join)
    "    #{name}: #{message}\n"
  end
  
  def full_url
    client.full_url
  end
  
  def upload
    client.assign_attributes(attributes)
    client.save if valid?
  end
  
  def valid?
    client.valid_with_server?
  end
  
  def errors
    client.error_messages
  end
  
  def client
    return @client if @client
    @client = Quandl::Client::Dataset.find(full_code)
    @client = Quandl::Client::Dataset.new unless @client.exists?
    @client
  end
  def client=(value)
    raise ArgumentError, "Expected Quandl::Client::Dataset received #{value.class}" unless value.is_a?(Quandl::Client::Dataset)
    @client = value
  end
  
end

end
end
end