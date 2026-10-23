module Craby
  # Minitest counterparts of the RSpec matchers in craby/matchers.
  # `node` defaults to Capybara's `page`.
  module Assertions
    # Runs a matcher (e.g. from Shoulda::Matchers) against a subject:
    #   assert_accepts validate_presence_of(:name), User.new
    def assert_accepts(matcher, subject)
      assert matcher.matches?(subject), -> { matcher.failure_message }
    end

    def assert_rejects(matcher, subject)
      refute matcher.matches?(subject), -> { matcher.failure_message_when_negated }
    end

    def assert_content_for(content, node = page)
      assert content.all? { node.has_content?(it) },
        "Expected to have #{content} in content"
    end

    def assert_resource_labels_for(resource, attributes, node = page)
      assert attributes.all? { node.has_content?(resource.send(it).to_s) },
        "Expected to have #{resource.class} labels #{attributes} in content"
    end

    def assert_resource_values_for(resource, attributes, node = page)
      assert attributes.all? { node.has_content?(resource.send(it).to_s) },
        "Expected to have #{resource.class} values #{attributes} in content"
    end
  end
end
