# frozen_string_literal: true

require "spec_helper"

RSpec.describe DbSeeder::Sanitizer do
  let(:config) { DbSeeder::Configuration.new }
  let(:model_class) do
    Class.new do
      def self.name = "User"
      def self.table_name = "users"
    end
  end

  it "returns attributes unchanged when there are no rules" do
    sanitizer = described_class.new(config)
    attrs = { email: "a@b.com", name: "Ana" }

    expect(sanitizer.sanitize(model_class, attrs)).to eq(attrs)
  end

  it "applies per-model per-attribute rules" do
    config.sanitize_rules = {
      users: {
        email: :random_email,
        name: ->(_v) { "Anonymous User" },
        phone: :null
      }
    }

    sanitizer = described_class.new(config)
    attrs = { email: "real@example.com", name: "Juan", phone: "555-123", other: "keep" }
    sanitized = sanitizer.sanitize(model_class, attrs)

    expect(sanitized[:email]).to match(/\Auser_[0-9a-f]{8}@example\.com\z/)
    expect(sanitized[:name]).to eq("Anonymous User")
    expect(sanitized[:phone]).to be_nil
    expect(sanitized[:other]).to eq("keep")
  end
end


