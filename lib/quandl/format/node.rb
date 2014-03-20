module Quandl
module Format
class Node
  
  SYNTAX = {
    comment:          '#',
    end_of_node:      '-',
  }
    
  attr_accessor :block, :line, :lines
  
  def initialize(*args)
    # options
    opts = args.extract_options!.symbolize_keys!
    # assign options
    self.line = opts[:line].to_i if opts[:line].present?
    self.block = opts[:block]
  end
  
  def add(value)
    increment_line
    # clean the value
    value = clean(value)
    # does this mark the end of the node?
    return close if end_of_node?(value)
    # handle the new line
    add_to_lines(value)
    # onwards
    self
  end
  
  def close
    # pass the node to the block
    block.call(self)
    # return a new node
    self.class.new( line: line, block: block )
  end
  
  def line
    @line ||= 0
  end
  
  def lines
    @lines ||= []
  end
  
  def as_json
    YAML.load(lines.join("\n"))
  end
  
  protected
  
  def increment_line
    self.line += 1
  end
  
  def add_to_lines(value)
    # ignore comments
    return false if comment?(value)
    # otherwise append the value
    lines << value
  end
  
  def end_of_node?(value)
    value[0] == SYNTAX[:end_of_node]
  end
  
  def comment?(value)
    value.blank? || value[0] == SYNTAX[:comment]
  end
  
  def clean(value)
    value.to_s.strip.rstrip
  end
  
end
end
end