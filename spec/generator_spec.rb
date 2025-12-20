# frozen_string_literal: true

require "spec_helper"
require "active_record"
require "fileutils"

RSpec.describe DbSeeder::Generator do
  let(:config) do
    DbSeeder::Configuration.new.tap do |c|
      c.output_path = "tmp/test_seeds"
      c.excluded_tables = ["schema_migrations"]
      c.batch_size = 100
    end
  end

  let(:generator) { described_class.new(config) }

  before do
    # Setup in-memory SQLite database
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )

    # Create test table
    ActiveRecord::Base.connection.create_table :test_users do |t|
      t.string :name
      t.string :email
      t.timestamps
    end

    # Create test model
    Object.const_set(:TestUser, Class.new(ActiveRecord::Base))

    # Insert test data
    TestUser.create!(name: "Juan Pérez", email: "juan@example.com")
    TestUser.create!(name: "María García", email: "maria@example.com")
  end

  after do
    FileUtils.rm_rf("tmp/test_seeds")
    ActiveRecord::Base.connection.drop_table(:test_users) if ActiveRecord::Base.connection.table_exists?(:test_users)
    Object.send(:remove_const, :TestUser) if Object.const_defined?(:TestUser)
  end

  describe "#generate" do
    it "generates seed file for specified table" do
      generator.generate("test_users")

      expect(File.exist?("tmp/test_seeds/test_users.rb")).to be true
    end

    it "generates seed files with valid Ruby code" do
      generator.generate("test_users")

      content = File.read("tmp/test_seeds/test_users.rb", encoding: "UTF-8")
      expect(content).to include("TestUser.create!")
      expect(content).to include("Juan Pérez")
      expect(content).to include("María García")
    end

    it "creates output directory if it doesn't exist" do
      expect(File.exist?("tmp/test_seeds")).to be false

      generator.generate("test_users")

      expect(File.exist?("tmp/test_seeds")).to be true
    end
  end
end

