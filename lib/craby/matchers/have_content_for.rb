RSpec::Matchers.define :have_content_for do |content|
  match do |actual|
    content.all? { actual.has_content?(it) }
  end

  failure_message do
    "Expected to have #{content} in content"
  end
end
