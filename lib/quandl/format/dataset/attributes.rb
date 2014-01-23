module Quandl
module Format
class Dataset

module Attributes
  
  extend ActiveSupport::Concern

  module ClassMethods

    META_ATTRIBUTES = :source_code, :code, :name, :description, :private, :reference_url
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
      raise_unknown_attribute_error!(key) unless respond_to?(key)
      self.send("#{key}=", value) 
    end
  end
  
  def full_code=(value)
    value = value.split('/')
    self.source_code = value[0]
    self.code = value[1]
  end

  def full_code
    [source_code, code].collect{|v| v.blank? ? nil : v }.compact.join('/')
  end

  def description=(value)
    @description = value.to_s.gsub('\n', "\n")
  end

  def data=(rows)
    @data = Quandl::Data.new(rows).to_date
    self.column_names = @data.headers if @data.headers.present?
    data_row_count_should_match_column_count!
    data_rows_should_have_equal_columns!
    @data
  end
  
  def column_names
    @column_names ||= []
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
    self.class.attribute_names.inject({}){|m,k| m[k] = self.send(k) unless self.send(k).nil?; m }
  end

  protected
  
  def data_rows_should_have_equal_columns!
    return if data.blank?
    row_count = data[0].count
    data.each_with_index do |row, index|
      raise_row_column_mismatch!(row, index) unless row.count == row_count
    end
  end
  
  def data_row_count_should_match_column_count!
    return if column_names.blank?
    column_count = column_names.count
    data.each_with_index do |row, index|
      raise_column_count_mismatch!(row, index) unless row.count == column_count
    end
  end
  

  private
  
  def raise_row_column_mismatch!(row, index)
    m = "Unexpected number of points in this row '#{row}'. Expected #{data[0].count} but found #{row.count} based on #{data[0]}"
    raise Quandl::Error::ColumnCountMismatch.new( row: row, line: index, context: 'data_rows_should_have_equal_columns!' ), m
  end
  
  def raise_column_count_mismatch!(row, index)
    m = "Unexpected number of points in this row '#{row}'. Expected #{column_names.count} but found #{row.count} based on #{column_names}"
    raise Quandl::Error::ColumnCountMismatch.new( row: row, line: index+1, context: 'data_row_count_should_match_column_count!' ), m
  end
  
  def raise_unknown_attribute_error!(key)
    m = "Unknown Field '#{key}' valid fields are: #{self.class.meta_attribute_names.join(', ')}"
    raise Quandl::Error::UnknownAttribute, m
  end


end

end
end
end