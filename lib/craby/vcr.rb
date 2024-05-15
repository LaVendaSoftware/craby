require "vcr"

VCR.configure do |cassette|
  cassette.cassette_library_dir = "spec/cassettes"
  cassette.hook_into :webmock
  cassette.configure_rspec_metadata!
  cassette.ignore_localhost = true
  # cassette.default_cassette_options = {re_record_interval: 30.days.to_i}
end
