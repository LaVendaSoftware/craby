require "vcr"

VCR.configure do |cassette|
  cassette.cassette_library_dir = "spec/cassettes"
  cassette.hook_into :webmock
  cassette.configure_rspec_metadata!
  cassette.ignore_localhost = true
  # cassette.default_cassette_options = {re_record_interval: 30.days.to_i}

  if ENV["VCR_IGNORED_DOMAINS"].present?
    cassette.ignore_request do |request|
      ENV["VCR_IGNORED_DOMAINS"].to_s.split(",").include?(URI(request.uri).host)
    end
  end
end
