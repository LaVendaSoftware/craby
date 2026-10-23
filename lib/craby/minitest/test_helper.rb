abort("The Rails environment is running in production mode!") if Rails.env.production? # rubocop:disable Rails/Exit

require "rails/test_help"

Rails.root.glob("test/support/**/*.rb").each { |f| require f }
