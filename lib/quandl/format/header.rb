require 'quandl/client/dataset/to_qdf'

module Quandl
  module Format

    class Header

      # classes
      require_relative 'header/load'

      # concerns
      require_relative 'header/attributes'

      include Quandl::Format::Header::Attributes

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

        def remove(input)
          header_index = 0
          start_data = 0
          input.each_line.with_index do |line, index|
            # skip comments and blank lines
            next if line.blank? || line[0] == Load::SYNTAX[:comment]

            if header_index==0
              header_index += 1
              line[0] != Load::SYNTAX[:header] ? break: next
            end

            #end of header
            if header_index > 0 && line[0] == Load::SYNTAX[:header]
              start_data = index + 1
              break
            end

            header_index += 1
          end

          input.lines.to_a[start_data..-1].join()
        end

      end


    end
  end
end