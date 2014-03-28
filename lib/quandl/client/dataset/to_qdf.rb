module Quandl
module Client

class Dataset
  
  def to_qdf
    return unless exists?
    Quandl::Format::Dataset.new( qdf_attributes ).to_qdf
  end
  
  def qdf_attributes
    Quandl::Format::Dataset.attribute_names.inject({}) do |memo, name|
      memo[name] = self.send(name) if self.respond_to?(name)
      memo
    end
  end
  
end

end
end