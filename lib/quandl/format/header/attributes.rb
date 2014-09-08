module Quandl
  module Format
    class Header

      module Attributes

        extend ActiveSupport::Concern

        module ClassMethods

          ATTRIBUTES = :notify, :token

          def attribute_names
            @attribute_names ||= ATTRIBUTES
          end

        end

        included do
          attribute_names.each do |name|
            attr_reader name unless method_defined?(name)
            attr_writer name unless method_defined?("#{name}=")
          end
        end

        def initialize(*args)
          attrs = args.extract_options!
          assign_attributes(attrs) if attrs.is_a?(Hash)
        end

        def assign_attributes(attrs)
          attrs.each do |key, value|
            raise_unknown_attribute_error!(key) unless respond_to?(key)
            self.send("#{key}=", value)
          end
        end

        def attributes
          self.class.attribute_names.inject({}){|m,k| m[k] = self.send(k) unless self.send(k).nil?; m }
        end

        private

        def raise_unknown_attribute_error!(key)
          m = "Unknown Field '#{key}' valid fields are: #{self.class.attribute_names.join(', ')}"
          raise Quandl::Error::UnknownAttribute, m
        end


      end

    end
  end
end