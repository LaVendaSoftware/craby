abort("The Rails environment is running in production mode!") if Rails.env.production?

require "rspec/rails"

Rails.root.glob("spec/support/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.render_views
end
