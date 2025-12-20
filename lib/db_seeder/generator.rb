# frozen_string_literal: true

require "active_record"

module DbSeeder
  class Generator
    attr_reader :config, :options

    def initialize(config, options = {})
      @config = config
      @options = options
    end

    def generate(table_name = nil)
      tables = table_name ? [table_name] : fetch_tables
      
      tables.each do |table|
        export_table(table)
      end
    end

    private

    def fetch_tables
      ActiveRecord::Base.connection.tables.reject do |table|
        config.excluded_tables.include?(table)
      end
    end

    def export_table(table_name)
      model_class = resolve_model(table_name)
      exporter = Exporter.new(model_class, config)
      formatter = Formatter.for(config.format)
      
      output = formatter.format(exporter.export)
      write_output(table_name, output)
    end

    def resolve_model(table_name)
      class_name = table_name.classify
      class_name.constantize
    rescue NameError
      create_anonymous_model(table_name)
    end

    def create_anonymous_model(table_name)
      Class.new(ActiveRecord::Base) do
        self.table_name = table_name
      end
    end

    def write_output(table_name, content)
      FileUtils.mkdir_p(config.output_path)
      file_path = File.join(config.output_path, "#{table_name}.rb")
      File.write(file_path, content)
    end
  end
end
