# frozen_string_literal: true

module DbSeeder
  module Formatter
    class Base
      def format(records)
        raise NotImplementedError
      end
    end

    class Ruby < Base
      def format(records)
        lines = records.map { |record| format_record(record) }
        lines.join("\n")
      end

      private

      def format_record(record)
        attributes = record.map { |k, v| "#{k}: #{value_to_ruby(v)}" }.join(", ")
        "  { #{attributes} },"
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

    def self.for(format_type)
      case format_type
      when :ruby then Ruby.new
      else raise Error, "Unknown format: #{format_type}"
      end
    end
  end
end

