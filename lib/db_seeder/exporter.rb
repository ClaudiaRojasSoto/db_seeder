# frozen_string_literal: true

module DbSeeder
  class Exporter
    attr_reader :model, :config

    def initialize(model, config)
      @model = model
      @config = config
      @sanitizer = DbSeeder::Sanitizer.new(config)
    end

    def export
      records = []
      model.find_in_batches(batch_size: config.batch_size) do |batch|
        records.concat(batch.map(&method(:serialize_record)))
      end
      records
    end

    private

    def serialize_record(record)
      raw =
        record
          .attributes
          .except("id", "created_at", "updated_at")
          .symbolize_keys

      @sanitizer.sanitize(model, raw)
    end
  end
end
