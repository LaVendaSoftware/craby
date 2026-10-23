# frozen_string_literal: true

require "minitest"
require "craby/assertions"

RSpec.describe Craby::Assertions do
  subject(:test) { test_class.new(node) }

  let(:test_class) do
    Class.new do
      include Minitest::Assertions
      include Craby::Assertions

      attr_accessor :assertions
      attr_reader :page

      def initialize(page)
        @page = page
        @assertions = 0
      end
    end
  end
  let(:node) { Struct.new(:text) { def has_content?(content) = text.include?(content) }.new("Jane Doe jane@example.com") }
  let(:user) { Struct.new(:name, :email).new("Jane Doe", "jane@example.com") }

  describe "#assert_accepts" do
    let(:matcher) do
      Struct.new(:expected) do
        def matches?(actual) = actual == expected
        def failure_message = "expected #{expected}"
        def failure_message_when_negated = "expected not #{expected}"
      end.new(1)
    end

    it "passes when the matcher matches" do
      expect(test.assert_accepts(matcher, 1)).to be(true)
    end

    it "fails with the matcher failure message" do
      expect { test.assert_accepts(matcher, 2) }.to raise_error(Minitest::Assertion, "expected 1")
    end

    it "passes the refutation when the matcher does not match" do
      expect(test.assert_rejects(matcher, 2)).to be(true)
    end

    it "fails the refutation with the negated failure message" do
      expect { test.assert_rejects(matcher, 1) }.to raise_error(Minitest::Assertion, "expected not 1")
    end
  end

  describe "#assert_content_for" do
    it "passes when every content is present" do
      expect(test.assert_content_for(["Jane", "Doe"])).to be(true)
    end

    it "fails when some content is missing" do
      expect { test.assert_content_for(["Jane", "John"]) }
        .to raise_error(Minitest::Assertion, 'Expected to have ["Jane", "John"] in content')
    end

    it "accepts a custom node" do
      other = Struct.new(:text) { def has_content?(content) = text.include?(content) }.new("John")

      expect(test.assert_content_for(["John"], other)).to be(true)
    end
  end

  describe "#assert_resource_labels_for" do
    it "passes when every attribute is present" do
      expect(test.assert_resource_labels_for(user, %i[name email])).to be(true)
    end

    it "fails when some attribute is missing" do
      user.email = "john@example.com"

      expect { test.assert_resource_labels_for(user, %i[name email]) }
        .to raise_error(Minitest::Assertion, /labels \[:name, :email\] in content/)
    end
  end

  describe "#assert_resource_values_for" do
    it "passes when every attribute is present" do
      expect(test.assert_resource_values_for(user, %i[name email])).to be(true)
    end

    it "fails when some attribute is missing" do
      user.name = "John"

      expect { test.assert_resource_values_for(user, %i[name]) }
        .to raise_error(Minitest::Assertion, /values \[:name\] in content/)
    end
  end
end
