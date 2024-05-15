module Craby
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("templates", __dir__)

    desc "Generates Craby setup files."
    def create_setup_files
      copy_file "craby_helper.rb", Rails.root.join("spec/craby_helper.rb")
      copy_file ".rspec", Rails.root.join(".rspec")
      copy_file ".rubocop.yml", Rails.root.join(".rubocop.yml")
      copy_file ".standard.yml", Rails.root.join(".standard.yml")
    end
  end
end
