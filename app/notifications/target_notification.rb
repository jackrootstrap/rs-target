# frozen_string_literal: true

class TargetNotification < Noticed::Base
  deliver_by :database
  deliver_by :email, mailer: 'TargetMailer', method: 'user_matched_targets'

  def message
    t('.message', user: user.name)
  end

  private

  def user
    @user ||= params[:user]
  end
end
