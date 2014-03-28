require 'quandl/client/dataset/to_qdf'

module Quandl
module Format

class Dataset

  # classes
  require_relative 'dataset/load'
  require_relative 'dataset/dump'
  
  # concerns
  require_relative 'dataset/attributes'
  require_relative 'dataset/client'
  
  include Quandl::Format::Dataset::Attributes
  include Quandl::Format::Dataset::Client

  class << self
    
    def each_line(interface, &block)
      Load.each_line(interface, &block)
    end
    
    def each_in_file(path, &block)
      Load.each_in_file(path, &block)
    end

    def load(input)
      Load.string(input)
    end

    def load_from_file(path)
      Load.string(File.read(path))
    end
    
    def dump(datasets)
      Dump.collection(datasets)
    end

  end
  

end  
end
end