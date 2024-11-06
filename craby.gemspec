# frozen_string_literal: true

require_relative "lib/craby/version"

Gem::Specification.new do |spec|
  spec.name = "craby"
  spec.version = Craby::VERSION
  spec.authors = ["Lavenda Software"]
  spec.email = ["lavenda@lavenda.com.br"]

  spec.summary = "Craby is just a quick test suite setup for Rails application"
  spec.homepage = "https://github.com/LavendaSoftware/craby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/blob/main/README.md"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/commits/main"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # https://github.com/presidentbeef/brakeman
  spec.add_dependency "brakeman"
  # https://github.com/standardrb/standard#usage
  spec.add_dependency "standard"
  # https://github.com/standardrb/standard-rails#usage
  spec.add_dependency "standard-rails"
  # https://github.com/rubocop/rubocop-rspec#usage
  spec.add_dependency "rubocop-rspec"
  # https://github.com/rubocop/rubocop-capybara#usage
  spec.add_dependency "rubocop-capybara"
  # https://github.com/rubocop/rubocop-factory_bot#usage
  spec.add_dependency "rubocop-factory_bot"
  # https://github.com/rubocop/rubocop-rspec_rails#usage
  spec.add_dependency "rubocop-rspec_rails"
  # https://github.com/Shopify/erb-lint#installation
  spec.add_dependency "erb_lint"
  # https://github.com/thoughtbot/factory_bot_rails
  spec.add_dependency "factory_bot_rails"
  # https://github.com/stympy/faker
  spec.add_dependency "faker"
  # https://github.com/thoughtbot/shoulda-matchers
  spec.add_dependency "shoulda-matchers"
  # https://github.com/rspec/rspec-rails#installation
  spec.add_dependency "rspec-rails"
  # https://github.com/DatabaseCleaner/database_cleaner
  spec.add_dependency "database_cleaner"
  # https://github.com/teamcapybara/capybara#setup
  spec.add_dependency "capybara"
  # https://github.com/SeleniumHQ/selenium/tree/trunk/rb#install
  spec.add_dependency "selenium-webdriver"
  # https://github.com/simplecov-ruby/simplecov#getting-started
  spec.add_dependency "simplecov"
  # https://github.com/vicentllongo/simplecov-json#usage
  spec.add_dependency "simplecov-json"
  # https://github.com/bblimke/webmock#rspec
  spec.add_dependency "webmock"
  # https://github.com/vcr/vcr#usage
  spec.add_dependency "vcr"
  # https://github.com/rails/rails-controller-testing#rspec
  spec.add_dependency "rails-controller-testing"
end
