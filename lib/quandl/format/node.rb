class Quandl::Format::Node
  
  META_ATTRIBUTES = :source_code, :code, :name, :description, :private, :display_url
  DATA_ATTRIBUTES = :column_names, :data
  
  attr_accessor *( META_ATTRIBUTES + DATA_ATTRIBUTES )

  class << self
    
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

  def initialize(attrs)
    assign_attributes(attrs)
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
    Quandl::Format::Dump.node(self)
  end

  def meta_attributes
    self.class.meta_attribute_names.inject({}){|m,k| m[k] = self.send(k); m }
  end

  def attributes
    self.class.attribute_names.inject({}){|m,k| m[k] = self.send(k); m }
  end

  def inspect
    "<##{self.class.name} #{meta_attributes.to_s} >"
  end
  
end