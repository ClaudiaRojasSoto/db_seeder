# frozen_string_literal: true

require "spec_helper"
require "active_record"

RSpec.describe DbSeeder do
  it "has a version number" do
    expect(DbSeeder::VERSION).not_to be nil
  end

  describe ".configure" do
    it "yields configuration" do
      DbSeeder.configure do |config|
        config.output_path = "custom/path"
      end
      
      expect(DbSeeder.configuration.output_path).to eq("custom/path")
    end
  end

  describe ".configuration" do
    it "returns default configuration" do
      config = DbSeeder::Configuration.new
      
      expect(config.output_path).to eq("db/seeds")
      expect(config.batch_size).to eq(1000)
      expect(config.format).to eq(:ruby)
    end
  end
end
