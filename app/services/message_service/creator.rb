# frozen_string_literal: true

module MessageService
  class Creator
    attr_reader :conversation, :body_message, :user, :conversations

    def initialize(conversation, body_message, current_user)
      @conversation = conversation
      @body_message = body_message
      @user = current_user
    end

    def call
      message = conversation.messages.create!(message_params)
      TargetNotification.with(user: @user).deliver_later(recipient)
      message
    end

    private 

    def message_params 
      @message_params ||= { body: body_message[:body], user_id: user.id }
    end

    def recipient
      @recipient ||= conversation.recipient(user)
    end
  end
end
