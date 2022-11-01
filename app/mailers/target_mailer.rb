# frozen_string_literal: true

class TargetMailer < ApplicationMailer
  def user_matched_targets
    @user = params[:user]
    @recipient = params[:recipient]
    mail(to: @recipient.email, subject: t('api.notifications.target_notification.message', user: @user.name))
  end
end
