require "craby/vcr/config"

VCR.configure do |cassette|
  cassette.cassette_library_dir = "spec/cassettes"
  cassette.configure_rspec_metadata!
end
