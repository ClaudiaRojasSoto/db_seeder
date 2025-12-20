# frozen_string_literal: true

namespace :db do
  namespace :seed do
    desc "Generate seed files from database tables"
    task generate: :environment do
      table = ENV["TABLE"]
      
      DbSeeder.generate(table)
      
      puts "Seed files generated in #{DbSeeder.configuration.output_path}"
    end

    desc "Generate seed files and run them"
    task regenerate: :environment do
      Rake::Task["db:seed:generate"].invoke
      Rake::Task["db:seed"].invoke
    end
  end
end
