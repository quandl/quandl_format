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

    def load(input)
      Load.string(input)
    end

    def load_from_file(path)
      Load.file(path)
    end

    def dump(datasets)
      Dump.collection(datasets)
    end

  end
  

end  
end
end