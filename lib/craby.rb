# frozen_string_literal: true

require_relative "craby/version"

module Craby
  class Error < StandardError; end

  class Setup
    DEFAULT_FILES = ["craby/default"]

    class << self
      def call(files = DEFAULT_FILES)
        files.each { |file| require file }
      end
    end
  end
end
