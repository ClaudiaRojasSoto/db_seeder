# frozen_string_literal: true

require_relative "db_seeder/version"
require_relative "db_seeder/configuration"
require_relative "db_seeder/generator"
require_relative "db_seeder/exporter"
require_relative "db_seeder/sanitizer"
require_relative "db_seeder/formatter"
require_relative "db_seeder/railtie" if defined?(Rails::Railtie)

module DbSeeder
  class Error < StandardError; end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def generate(table_name = nil, **options)
      Generator.new(configuration, options).generate(table_name)
    end
  end
end
