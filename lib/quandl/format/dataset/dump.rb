class Quandl::Format::Dataset::Dump
  
  class << self

    def collection(*args)
      Array(args).flatten.collect{|r| record(r) }.join("\n")
    end

    def record(record)
      self.new(record).to_qdf
    end

  end

  attr_accessor :record

  def initialize(r)
    self.record = r
  end

  def to_qdf
    [ 
      meta_attributes,
      column_names,
      data
    ].compact.join
  end

  def meta_attributes
    record.meta_attributes.stringify_keys.to_yaml[4..-1] + "-\n"
  end
  
  def data
    data = record.data
    data = data.collect(&:to_csv).join if data.is_a?(Array) && data.first.respond_to?(:to_csv)
    data = data.to_csv if data.respond_to?(:to_csv)
    data
  end

  def column_names
    record.column_names.to_csv if record.column_names.present?
  end

end