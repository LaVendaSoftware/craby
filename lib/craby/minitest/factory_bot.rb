require "factory_bot_rails"

ActiveSupport.on_load(:active_support_test_case) do
  include FactoryBot::Syntax::Methods
end
