# frozen_string_literal: true

DeviseTokenAuth.setup do |config|
  config.change_headers_on_each_request = false
  config.token_cost = Rails.env.test? ? 4 : 10
  config.default_confirm_success_url = 'http://localhost:3000'
end
