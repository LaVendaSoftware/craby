# Craby

Craby is just a quick test suite setup that uses RSpec (or Minitest) with Shoulda::Matchers, Capybara with Selenium, DatabaseCleaner, FactoryBot, Faker (with `Faker::CPF` and `Faker::CNPJ` from cpf_faker), Standard Ruby and bundler-audit as default. And it also has webmock and VRC for applications that need to test third-party services

## Installation

Add this line to your application's Gemfile:

```ru
gem "craby", "~> 0.2"
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
bundle add craby
```

## Usage (RSpec)

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

## Usage (Minitest)

Run the generator with the `minitest` test framework:

```sh
rails g craby:install --test-framework=minitest
```

It replaces `test/test_helper.rb` with:

```rb
ENV["RAILS_ENV"] ||= "test"

require "craby"

Craby::Setup.call([
  "craby/simplecov",
  File.expand_path("config/environment", File.dirname(__dir__)),
  "craby/minitest/default"
])
```

`craby/minitest/default` loads `rails/test_help`, files in `test/support`, Capybara, FactoryBot, Faker, Shoulda::Matchers and Craby assertions into `ActiveSupport::TestCase`.

Optional files you can add to the `Craby::Setup.call` list:

- `craby/minitest/webmock`: blocks external HTTP requests
- `craby/minitest/vcr`: records cassettes in `test/cassettes`
- `craby/minitest/database_cleaner`: truncates the database after each test (only needed when transactional tests are not enough)

Use the Chrome driver in your system tests:

```rb
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :chrome
end
```

Shoulda::Matchers and Craby assertions:

```rb
class UserTest < ActiveSupport::TestCase
  test "validations" do
    assert_accepts validate_presence_of(:name), User.new
    assert_rejects validate_presence_of(:nickname), User.new
  end
end

class UsersTest < ApplicationSystemTestCase
  test "shows the user" do
    user = create(:user)
    visit user_path(user)

    assert_content_for [user.name, user.email]
    assert_resource_values_for user, %i[name email]
  end
end
```

The generator also creates a `.rubocop.yml` with `rubocop-minitest` instead of the RSpec plugins.

## bundler-audit

The generator also creates `bin/bundler-audit` and `config/bundler-audit.yml` (both are skipped when they already exist, like in Rails 8.1+ apps). Run the audit with:

```sh
bin/bundler-audit
```

CVEs that don't apply to your application go in the `ignore` list of `config/bundler-audit.yml`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/craby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
