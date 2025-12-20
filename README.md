# DbSeeder

Generate Rails seed files from your existing database data. Perfect for creating seeds from production data, test fixtures, or sharing database states across teams.

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

## Development

```bash
bundle install
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/claudiapatriciarojassoto/db_seeder.

## License

MIT License. See LICENSE.txt for details.
