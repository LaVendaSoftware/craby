require "craby/assertions"

ActiveSupport.on_load(:active_support_test_case) do
  include Craby::Assertions
end
