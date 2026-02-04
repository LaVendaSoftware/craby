RSpec::Matchers.define :have_resource_values_for do |resource, attributes|
  match do |actual|
    attributes.all? do |attribute|
      actual.has_content?(resource.send(attribute).to_s)
    end
  end

  failure_message do
    "Expected to have #{resource.class} values #{attributes} in content"
  end
end
