class Quandl::Format::Header::Load

  SYNTAX = {
      comment:          '#',
      delimiter:          ':',
      attribute:        /^([a-z0-9_]+): (.+)/,
      header:           '='
  }

  class << self

    def file(path)
      string( File.read(path) )
    end

    def string(input)
      # prepare to collect all datasets
      header_attributes = {}

      # for each line
      header_index = 0
      input.each_line do |line|
        # skip comments and blank lines
        next if line.blank? || line[0] == SYNTAX[:comment]

        if header_index==0
          header_index += 1
          line[0] != SYNTAX[:header] ? break: next
        end

        #end of header
        break if header_index > 0 && line[0] == SYNTAX[:header]
        # process each line when encountering dataset append it to datasets
        process_line(line) {|k, v| header_attributes[k] = v}
        header_index += 1
      end
      return nil if header_attributes.empty?
      # return header
      Quandl::Format::Header.new( header_attributes )
    end

    def process_line(rline, &block)
      # strip whitespace
      line = rline.strip.rstrip

      # looking at an attribute?
      if line =~ SYNTAX[:attribute]
        k, temp, v = line.partition(SYNTAX[:delimiter])
        block.call(k.strip.rstrip,v.strip.rstrip)
      else
        m = "Header line is not in format 'attribute: value' - #{line}"
        raise Quandl::Error::InvalidHeader, m
      end

    end


  end

end