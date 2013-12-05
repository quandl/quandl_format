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
      input.each_line do |rline|
        # strip whitespace
        line = rline.strip.rstrip
        # ignore comments and blank lines
        next if line[0] == '#' || line.blank?
        
        # are we looking at an attribute?
        if line =~ attribute_format
          # if we are leaving the data section
          # then this is the start of a new node
          nodes << { attributes: '', data: '' } if section_type == :data
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
      nodes.collect do |node|
        # parse attrs as yaml
        node[:attributes] = YAML.load( node[:attributes] ).symbolize_keys!
        # parse data as csv
        node[:attributes][:data] = CSV.parse(node[:data])
        node
      end
    end
    
    def nodes_to_datasets(nodes)
      datasets = []
      nodes.each_with_index do |node, index|
        dataset = node_to_dataset(node, index)
        datasets << dataset if dataset
      end
      datasets
    end
    
    def node_to_dataset(node, index)
      Quandl::Format::Dataset.new( node[:attributes] )
    rescue => e# Quandl::Format::Errors::UnknownAttribute => e
      message = "Error: Dataset #{index + 1}\n"
      message += node[:attributes][:source_code] + '/' if node[:attributes][:source_code].present?
      message += node[:attributes][:code] + "\n"
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