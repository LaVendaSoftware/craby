require "database_cleaner"

module DatabaseCleaner
  module ActiveRecord
    class Base < DatabaseCleaner::Strategy
      def self.migration_table_name
        if Gem::Version.new("6.0.0") <= ::ActiveRecord.version
          ::ActiveRecord::Base.connection_pool.schema_migration.table_name
        else
          ::ActiveRecord::SchemaMigration.table_name
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.before do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end
end
