# DbSeeder

**A modern Rails gem to generate seed files from your existing database data.**

Perfect for creating seeds from production data, sharing database states across teams, or migrating data between environments.

## Why DbSeeder?

While similar gems exist, DbSeeder offers several advantages:

- ✅ **Modern & Maintained** - Built for Rails 7+, actively maintained
- ✅ **Memory Efficient** - Batch processing for large tables (won't crash on millions of records)
- ✅ **SOLID Architecture** - Clean, testable, maintainable code
- ✅ **Flexible Configuration** - Customize output path, excluded tables, batch size, and more
- ✅ **Well Tested** - Comprehensive test suite with 100% core functionality coverage

### DbSeeder vs Other Solutions

| Feature | DbSeeder | seed_dump | Faker |
|---------|----------|-----------|-------|
| Purpose | Export real data | Export real data | Generate fake data |
| Rails 7+ | ✅ Yes | ⚠️ Unmaintained since 2015 | ✅ Yes |
| Batch Processing | ✅ Yes | ❌ No | N/A |
| Configurable | ✅ Yes | Limited | N/A |
| Use Case | Production → Seeds | Production → Seeds | Testing/Development |

**Use DbSeeder when:** You need to export real database records to seed files  
**Use Faker when:** You need to generate fake/random data for testing

## Installation

Add to your Gemfile:

```ruby
gem 'db_seeder'
```

Then execute:
```bash
bundle install
```

## Usage

### Basic Usage

Generate seeds for all tables:
```bash
rake db:seed:generate
```

Generate seeds for specific table:
```bash
rake db:seed:generate TABLE=users
```

### Configuration

Create an initializer `config/initializers/db_seeder.rb`:

```ruby
DbSeeder.configure do |config|
  config.output_path = "db/seeds"
  config.excluded_tables = %w[schema_migrations ar_internal_metadata sessions]
  config.batch_size = 1000
  config.format = :ruby
  config.sanitize_rules = {
    users: {
      email: :random_email,
      name: ->(_v) { "Anonymous User" }
    }
  }
end
```

### Programmatic Usage

```ruby
DbSeeder.generate("users")

DbSeeder.generate
```

## Configuration Options

- `output_path`: Directory for generated seed files (default: "db/seeds")
- `excluded_tables`: Tables to skip (default: schema_migrations, ar_internal_metadata)
- `batch_size`: Records per batch (default: 1000)
- `format`: Output format (default: :ruby)
- `sanitize_rules`: Per-table attribute sanitization rules (default: {})

## Development

```bash
bundle install
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ClaudiaRojasSoto/db_seeder.

## License

MIT License. See LICENSE.txt for details.
