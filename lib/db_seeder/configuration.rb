# frozen_string_literal: true

module DbSeeder
  class Configuration
    attr_accessor :output_path, :excluded_tables, :batch_size, :format, :sanitize_rules

    def initialize
      @output_path = "db/seeds"
      @excluded_tables = %w[schema_migrations ar_internal_metadata]
      @batch_size = 1000
      @format = :ruby
      @sanitize_rules = {}
    end
  end
end
