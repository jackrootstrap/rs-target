# frozen_string_literal: true

module Helpers
  def json
    JSON.parse(response.body).with_indifferent_access
  end

  def errors
    json[:errors]
  end
end
