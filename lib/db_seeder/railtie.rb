# frozen_string_literal: true

require "rails/railtie"

module DbSeeder
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/db_seeder.rake"
    end
  end
end
