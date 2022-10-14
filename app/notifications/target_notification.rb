# frozen_string_literal: true

class TargetNotification < Noticed::Base
  deliver_by :database

  def message
    t('.message', user: user.name)
  end

  private

  def user
    @user ||= params[:user]
  end
end
