module Craby
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    class_option :test_framework, type: :string, default: "rspec", enum: %w[rspec minitest],
      desc: "Test framework to set up"

    desc "Generates Craby setup files."
    def create_setup_files
      copy_file ".standard.yml", Rails.root.join(".standard.yml")

      if options[:test_framework] == "minitest"
        create_minitest_files
      else
        create_rspec_files
      end
    end

    private

    def create_rspec_files
      copy_file "craby_helper.rb", Rails.root.join("spec/craby_helper.rb")
      copy_file ".rspec", Rails.root.join(".rspec")
      copy_file ".rubocop.yml", Rails.root.join(".rubocop.yml")
      system "bin/bundle binstub brakeman rubocop rspec-core --force"
    end

    def create_minitest_files
      copy_file "minitest/test_helper.rb", Rails.root.join("test/test_helper.rb")
      copy_file "minitest/.rubocop.yml", Rails.root.join(".rubocop.yml")
      system "bin/bundle binstub brakeman rubocop --force"
    end
  end
end
