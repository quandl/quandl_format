module Quandl
module Format
class Dataset

module Client
  extend ActiveSupport::Concern
  
  included do
    include ActiveModel::Validations
    
    validate :data_should_be_valid!
    validate :client_should_be_valid!
    
  end
  
  def human_errors
    m = "#{client.human_status} \t #{client.full_url}"
    return m if errors.blank?
    m += "\n  errors: \n"
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
    client.save if valid?
  end
  
  def client
    @client ||= find_or_build_client
  end
  def client=(value)
    raise ArgumentError, "Expected Quandl::Client::Dataset received #{value.class}" unless value.is_a?(Quandl::Client::Dataset)
    @client = value
  end
  
  
  protected
  
  def data_should_be_valid!
    if @data.respond_to?(:valid?) && !data.valid?
      data.errors.each{|err, value| self.errors.add( err, value ) }
      return false
    end
    true
  end
  
  def client_should_be_valid!
    if !client.valid_with_server?
      client.errors.each{|err, value| self.errors.add( err, value ) }
      return false 
    end
    true
  end
  
  def find_or_build_client
    @client ||= Quandl::Client::Dataset.find(full_code)
    @client = Quandl::Client::Dataset.new unless @client.try(:exists?)
    @client.assign_attributes(attributes)
    @client
  end
  
end

end
end
end