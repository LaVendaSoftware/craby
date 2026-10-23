require "database_cleaner"

module Craby
  module DatabaseCleaner
    def before_setup
      ::DatabaseCleaner.start
      super
    end

    def after_teardown
      super
      ::DatabaseCleaner.clean
    end
  end
end

DatabaseCleaner.clean_with(:truncation)
DatabaseCleaner.strategy = :truncation

ActiveSupport.on_load(:active_support_test_case) do
  include Craby::DatabaseCleaner
end
