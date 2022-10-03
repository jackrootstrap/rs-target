# frozen_string_literal: true

class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent
  before_action :authenticate_user!

  rescue_from ActiveRecord::RecordNotFound,        with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid,         with: :render_invalid

  private

  def render_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def render_invalid(exception)
    render json: { message: exception.message }, status: :unprocessable_entity
  end
end
