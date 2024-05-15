require "capybara/rails"
require "capybara/rspec"

require "selenium-webdriver"

Capybara.register_driver :chrome do |app|
  args = ["disable-gpu"]
  headless = ActiveModel::Type::Boolean.new.cast(ENV.fetch("HEADLESS", true))
  args << "headless" if headless
  options = Selenium::WebDriver::Chrome::Options.new(args: args)

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome
