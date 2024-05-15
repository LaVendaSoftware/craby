ENV["RAILS_ENV"] ||= "test"

require "craby"

Craby::Setup.call([
  "craby/simplecov",
  File.expand_path("config/environment", File.dirname(__dir__)),
  "craby/default"
])
