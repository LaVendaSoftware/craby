# Craby

Craby is just a quick test suite setup that uses RSpec with Shoulda::Matchers, Capybara with Selenium, DatabaseCleaner, FactoryBot, Faker, Standard Ruby as default. And it also has webmock and VRC for applications that need to test third-party services

## Installation

Add this line to your application's Gemfile:

```ru
gem "craby", "~> 0.0.1"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
bundle add craby
```

## Usage

You can use a Rails generator to create setup files:

```sh
rails g craby:install
```

Or you can create manually `spec/craby_helper.rb` file in your rails application:

```rb
ENV["RAILS_ENV"] ||= "test"

require "craby"

Craby::Setup.call([
  "craby/simplecov",
  File.expand_path("config/environment", File.dirname(__dir__)),
  "craby/default"
])
```

And `.rspec` file in your root rails application:

```
--require craby_helper
--format documentation
--force-color
--order rand
```

Create `.standard.yml` file in your root rails application:

```yml
ruby_version: 3.3
```

Create `.rubocop.yml` file in your root rails application:

```yml
require:
  - rubocop-rails
  - rubocop-factory_bot
  - rubocop-capybara
  - rubocop-rspec

inherit_gem:
  standard: config/base.yml

AllCops:
  NewCops: enable
  TargetRubyVersion: 3.3
  TargetRailsVersion: 7.1
  Exclude:
    - "bin/**/*"
    - "config/environments/**/*"
    - "db/schema.rb"
    - "db/seeds.rb"
    - "tmp/**/*"
    - "vendor/**/*"
```

If your application was a full stack rails application you should create a `.erb-lint.yml` file:

```yml
EnableDefaultLinters: true
linters:
  ErbSafety:
    enabled: true
  Rubocop:
    enabled: true
    rubocop_config:
      inherit_from:
        - .rubocop.yml
      Style/FrozenStringLiteralComment:
        Enabled: false
      Layout/InitialIndentation:
        Enabled: false
      Layout/TrailingEmptyLines:
        Enabled: false
      Layout/TrailingWhitespace:
        Enabled: false
      Rails/OutputSafety:
        Enabled: false
      Lint/UselessAssignment:
        Enabled: false
```

And generate `bin/erblint`:

```sh
bin/bundle binstub erb_lint
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/craby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
