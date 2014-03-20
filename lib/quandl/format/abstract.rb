require 'quandl/format/node'

module Quandl
module Format
class Abstract

  class << self
    
    def load(interface)
      output = []
      foreach(interface){|n| output << n }
      output
    end
    
    def foreach(interface, &block)
      each_line_as_node(interface) do |node|
        call_and_catch_block(node, &block)
      end
    end
    
    def each_line_as_node(interface, &block)
      # initialize an empty node
      node = Quandl::Format::Node.new( block: block )
      # for each_line of the interface
      interface.each_line do |line|
        # add the line to the node
        node = node.add( line )
      end
      # we're done
      node.close
    end
    
    
    protected
    
    def call_and_catch_block(node, &block)
      # convert the node to an instance of superset
      node = before_call(node)
      # pass the superset to the block
      block.call( node )
    rescue Exception => error
      block.call( error )
    end
    
    def before_call(node)
      node
    end
     
  end
  
end
end
end