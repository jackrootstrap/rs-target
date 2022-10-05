# frozen_string_literal: true

class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent
  before_action :authenticate_user!

  rescue_from Exception, with: :render_default_exception

  private

  def render_default_exception(exception)
    render json: { errors: exception.message }, status: :bad_request
  end
end
