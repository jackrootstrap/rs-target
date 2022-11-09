# frozen_string_literal: true

class ApiController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActiveStorage::SetCurrent
  before_action :authenticate_user!

  rescue_from Exception,                         with: :render_default_exception
  rescue_from ActiveRecord::RecordInvalid,       with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound,      with: :render_not_found

  private

  def render_invalid(exception)
    render json: { errors: exception.message }, status: :unprocessable_entity
  end

  def render_default_exception(exception)
    render json: { errors: exception.message }, status: :bad_request
  end

  def render_not_found(exception)
    render json: { errors: exception.message }, status: :not_found
  end
end
