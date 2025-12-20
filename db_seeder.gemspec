# frozen_string_literal: true

require_relative "lib/db_seeder/version"

Gem::Specification.new do |spec|
  spec.name = "db_seeder"
  spec.version = DbSeeder::VERSION
  spec.authors = ["Claudia P. R. Soto"]
  spec.email = ["claudiarojassoto@gmail.com"]

  spec.summary = "Generate Rails seeds from existing database data"
  spec.description = "A Rails gem that automatically generates seed files from your existing database records, making it easy to replicate data across environments"
  spec.homepage = "https://github.com/ClaudiaRojasSoto/db_seeder"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ClaudiaRojasSoto/db_seeder"
  spec.metadata["changelog_uri"] = "https://github.com/ClaudiaRojasSoto/db_seeder/blob/main/CHANGELOG.md"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3", "~> 1.4"
end
