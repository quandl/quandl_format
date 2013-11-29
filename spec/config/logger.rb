module Spec
class Logger
  
  class << self
    
    def info(*args)
      log(*args)
    end
    
    def debug(*args)
      log(*args)
    end
    
    def error(*args)
      raise args[1] if args[1].kind_of?(StandardError)
    end
    
    def log(*args)
      STDOUT << args.collect(&:to_s).join(', ') + "\n"
    end
    
  end
  
end
end