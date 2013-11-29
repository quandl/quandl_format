module Quandl
module Format
class Dataset

module Attributes
  
  extend ActiveSupport::Concern

  module ClassMethods

    META_ATTRIBUTES = :source_code, :code, :name, :description, :private, :display_url
    DATA_ATTRIBUTES = :column_names, :data

    def attribute_names
      @attribute_names ||= meta_attribute_names + data_attribute_names
    end

    def meta_attribute_names
      META_ATTRIBUTES
    end

    def data_attribute_names
      DATA_ATTRIBUTES
    end
    
  end
  
  included do
    attribute_names.each do |name|
      attr_reader name unless method_defined?(name)
      attr_writer name unless method_defined?("#{name}=")
    end
  end
  
  def initialize(*args)
    attrs = args.extract_options!
    assign_attributes(attrs) if attrs.is_a?(Hash)
  end

  def assign_attributes(attrs)
    attrs.each do |key, value|
      self.send("#{key}=", value) if self.respond_to?(key)
    end
  end

  def full_code=(value)
    value = value.split('/')
    self.source_code = value[0]
    self.code = value[1]
  end

  def full_code
    [source_code, code].join('/')
  end

  def description=(value)
    @description = value.to_s.gsub('\n', "\n")
  end

  def data=(rows)
    self.column_names = rows.shift unless rows.first.collect{|r| r.to_s.numeric? }.include?(true)
    @data = rows
  end

  def column_names=(names)
    @column_names = Array(names).flatten.collect{|n| n.strip.rstrip }
  end

  def to_qdf
    Dump.record(self)
  end

  def meta_attributes
    self.class.meta_attribute_names.inject({}){|m,k| m[k] = self.send(k); m }
  end

  def attributes
    self.class.attribute_names.inject({}){|m,k| m[k] = self.send(k); m }
  end

  def inspect
    attrs = attributes.collect do |key, value|
      if value.is_a?(String)
        value = "#{value[0..20]}..." if value.length > 20
        value = "'#{value}'"
      end
      "#{key}: #{value}"
    end
    %Q{<##{self.class.name} #{attrs.join(', ')}>}
  end

end

end
end
end