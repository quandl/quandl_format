module Quandl
module Format

class Dump

  class << self

    def nodes(*args)
      Array(args).flatten.collect{|r| node(r) }.join("\n")
    end

    def node(node)
      self.new(node).to_qdf
    end

  end

  attr_accessor :node

  def initialize(r)
    self.node = r
  end

  def to_qdf
    [ 
      meta_attributes,
      column_names,
      data
    ].compact.join
  end

  def meta_attributes
    node.meta_attributes.stringify_keys.to_yaml[4..-1] + "-\n"
  end
  
  def data
    data = node.data
    data = data.collect(&:to_csv).join if data.is_a?(Array) && data.first.respond_to?(:to_csv)
    data = data.to_csv if data.respond_to?(:to_csv)
    data
  end

  def column_names
    node.column_names.to_csv if node.column_names.present?
  end

end

end
end