# frozen_string_literal: true

class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent
  before_action :authenticate_user!
end
