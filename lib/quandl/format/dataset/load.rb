class Quandl::Format::Dataset::Load
  
  SECTION_DELIMITER = '-'
  
  class << self
    
    def file(path)
      string(File.read(path).strip)
    end
  
    def string(input)
      nodes = parse_string(input)
      nodes = parse_yaml_and_csv(nodes)
      nodes = nodes_to_datasets(nodes)
      nodes
    end
    
    protected
    
    def parse_string(input)
      nodes = []
      section_type = :data
      line_index = 0
      input.each_line do |rline|
        # track current line index
        line_index += 1
        # strip whitespace
        line = rline.strip.rstrip
        # ignore comments and blank lines
        next if line[0] == '#' || line.blank?
        
        # are we looking at an attribute?
        if line =~ attribute_format
          # if we are leaving the data section
          # then this is the start of a new node
          nodes << { attributes: '', data: '', line: line_index } if section_type == :data
          # update the section to attributes
          section_type = :attributes
          
          # have we reached the end of the attributes?
        elsif line[0] == '-'
          # update the section to data
          section_type = :data
          # skip to the next line
          next
        end
        # add the line to it's section in the current node.
        # YAML must include whitespace
        nodes[-1][section_type] += (section_type == :data) ? "#{line}\n" : rline
      end
      nodes
    end
    
    def parse_yaml_and_csv(nodes)
      output = []
      nodes.each do |node|
        # parse attrs as yaml
        node[:attributes] = parse_yaml_attributes(node)
        # we cant continue unless attributes are present
        next if node[:attributes].blank?
        # parse data as csv
        node[:attributes][:data] = CSV.parse(node[:data])
        # onwards
        output << node
      end
      output
    end
    
    def nodes_to_datasets(nodes)
      datasets = []
      nodes.each do |node|
        dataset = node_to_dataset(node)
        datasets << dataset if dataset
      end
      datasets
    end
    
    def parse_yaml_attributes(node)
      YAML.load( node[:attributes] ).symbolize_keys!
    rescue => e
      message = "Error: Dataset starting at line #{node[:line]}\n"
      message += "#{$!}\n"
      message += "--"
      Quandl::Logger.error(message)
      nil
    end
    
    def node_to_dataset(node)
      Quandl::Format::Dataset.new( node[:attributes] )
    rescue => e
      message = ''
      message += node[:attributes][:source_code] + '/' if node[:attributes][:source_code].present?
      message += node[:attributes][:code] + ' '
      message += "error around line #{node[:line]} \n"
      message += "#{$!}\n"
      message += "--"
      Quandl::Logger.error(message)
      nil
    end
    
    def attribute_format
      /^([a-z0-9_]+): (.+)/
    end
  
  end

end