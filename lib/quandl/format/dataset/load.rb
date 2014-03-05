class Quandl::Format::Dataset::Load
  
  SYNTAX = {
    comment:          '#',
    data:             '-',
    attribute:        /^([a-z0-9_]+): (.+)/,
  }
  
  class << self
    
    def each_in_file(path, &block)
      each_line( File.open(path, "r"), &block )
    end
    
    def each_line(interface, &block)
      node = new_node
      # for each file line
      interface.each_line do |line|
        # process line
        node = process_line(line, node, &block)
      end
      process_tail(node, &block)
    end
    
    def file(path)
      string( File.read(path) )
    end
    
    def string(input)
      # prepare to collect all datasets
      datasets = []
      # initialize blank node
      node = new_node
      # for each line
      input.each_line do |line|
        # process each line when encountering dataset append it to datasets
        node = process_line( line, node ){|d| datasets << d }
      end
      # signify end
      process_tail(node){|d| datasets << d }
      # return datasets
      datasets
    end
    
    def new_node(line=0)
      { line: line, section: :attributes, data: '', attributes: '', data_line: 0, offset: line==0 ? 0 : line-1 }
    end
    
    def process_tail(node, &block)
      # signify end
      process_line('-', node, &block)
      process_line('tail: end', node, &block)
    end
    
    def process_line(rline, node, &block)
      # increment node line
      node[:line] += 1
      # strip whitespace
      line = rline.strip.rstrip
      # skip comments and blank lines
      if line[0] == SYNTAX[:comment] || line.blank?
        node[:attributes] += "\n" if node[:section] == :attributes
        return node
      end
      # looking at an attribute?
      if line =~ SYNTAX[:attribute]
        # exiting data section?
        if node[:section] == :data
          # we've reached the end of a node
          # send it to the server
          process_node(node, &block)
          # start a new node while retaining current line line
          node = new_node( node[:line] )
        end
        # update the node's section
        node[:section] = :attributes
      # entering the data section?
      elsif line[0] == SYNTAX[:data]
        # update the node
        node[:data_line] = node[:line] + 1
        node[:section] = :data
        # skip to the next line
        return node
      end
      # append the line to the requested section
      node[ node[:section] ] += ( node[:section] == :data ) ? "#{line}\n" : rline
      # return the updated node
      node
    end
    
    def process_node(node, &block)
      begin
        node = parse_node(node)
        # fail on errored node
        return false if node == false
        # convert node to dataset
        dataset = convert_node_to_dataset(node)
        # do whatever we need to do with the node
        block.call( dataset, nil ) unless dataset.nil?
        # success
        true
        
      rescue Exception => err
        block.call( nil, err )
        false
        
      end
    end
    
    def parse_node(node)
      # parse attrs as yaml
      node[:attributes] = parse_yaml_attributes(node)
      # we cant continue unless attributes are present
      return false if node[:attributes].blank?
      # parse data as csv
      node[:data] = Quandl::Data::Format.csv_to_array(node[:data])
      node
    end
  
    protected
    
    def parse_yaml_attributes(node)
      attrs = {}
      attributes = YAML.load( node[:attributes] )
      raise 'Unparsable input'  unless attributes.is_a? Hash
      attributes.symbolize_keys!.each do |key, value|
        attrs[key.to_s.downcase.to_sym] = value
      end
      attrs
    rescue Exception => err
      m = generate_yaml_parse_error(node, err)
      raise err, m
    end
    
    def convert_node_to_dataset(node)
      dataset = Quandl::Format::Dataset.new( node[:attributes] )
      dataset.data = node[:data]
      dataset
    rescue Exception => err
      m = generate_dataset_error(node, err)
      raise err, m
    end
    
    def generate_yaml_parse_error(node, err)
      message = ""
      if err.message == 'Unparsable input'
        message = "Input data is unparsable.  Are you missing a colon (:) or a space after a colon?\n"
      elsif err.is_a?(Psych::SyntaxError) && err.respond_to?(:problem)
        if err.problem =~ /mapping values are not allowed in this context/
          message = "Syntax error *before* line #{1+node[:offset] + err.line}.\n"
          if node[:attributes] =~ /:.+:/ # he probably has a colon in a field.
            message += "You might have an illegal colon (:) in one of your fields.  If so, use quotes.\n"
          elsif node[:attributes] =~ /^([^:]+)$/ # he forgot the colon completely
            message += "Did you forget a colon on this line:\n"
            message += "#{$1}\n"
          end
        else
          message += "Error parsing metadata. #{err.problem.capitalize} on line #{node[:offset] + err.line}\n"
          if err.problem =~ /expected ':'/
            message += "Did you forget to delimit the meta data section from the data section with a one or more dashes ('#{SYNTAX[:data]}')?\n"
          end
        end
      elsif err.is_a?(Psych::SyntaxError)
        message = err.to_s + "\n" + node[:attributes]
      else
        message += "Attribute parse error at line #{ node[:line] + err.line } column #{err.column}. #{err.problem} (#{err.class})\n" if node.has_key?(:line) && err.respond_to?(:line)
        message += "Encountered error while parsing: \n  " + node[:attributes].split("\n")[err.line - 1].to_s if err.respond_to?(:line)
      end
      message += "\n"
      message
    end
    
    def generate_dataset_error( node, err )
      message = ''
      message += node[:attributes][:source_code] + '/' if node[:attributes][:source_code].present?
      message += node[:attributes][:code] + ' '
      # include specific line if available
      if err.respond_to?(:line)
        message += "error at line #{node[:data_line].to_i + err.line.to_i}\n"
      else
        message += "error around line #{node[:line]}\n"
      end
      # include original error
      message += "#{$!} (#{err.class})"
      message += "\n"
      message
    end
    
  end

end