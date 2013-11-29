module Quandl
module Format

class Dataset

  # classes
  require_relative 'dataset/load'
  require_relative 'dataset/dump'
  
  # concerns
  require_relative 'dataset/attributes'
  include Quandl::Format::Dataset::Attributes

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