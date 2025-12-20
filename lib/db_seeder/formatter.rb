# frozen_string_literal: true

module DbSeeder
  module Formatter
    class Base
      def format(records)
        raise NotImplementedError
      end
    end

    class Ruby < Base
      def initialize(model_name = nil)
        @model_name = model_name
      end

      def format(records)
        return "" if records.empty?
        
        lines = ["# frozen_string_literal: true", ""]
        lines << "# Seeds for #{@model_name}" if @model_name
        lines << ""
        
        records.each do |record|
          lines << format_record(record)
        end
        
        lines.join("\n")
      end

      private

      def format_record(record)
        attributes = record.map { |k, v| "  #{k}: #{value_to_ruby(v)}" }.join(",\n")
        "#{@model_name}.create!(\n#{attributes}\n)\n"
      end

      def value_to_ruby(value)
        case value
        when String then "'#{value.gsub("'", "\\\\'")}'"
        when Symbol then ":#{value}"
        when NilClass then "nil"
        when TrueClass, FalseClass, Numeric then value.to_s
        when Time, Date, DateTime then "'#{value.iso8601}'"
        else value.inspect
        end
      end
    end

    def self.for(format_type, model_name = nil)
      case format_type
      when :ruby then Ruby.new(model_name)
      else raise Error, "Unknown format: #{format_type}"
      end
    end
  end
end
