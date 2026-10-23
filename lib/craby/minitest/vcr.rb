require "craby/vcr/config"

VCR.configure do |cassette|
  cassette.cassette_library_dir = "test/cassettes"
end
