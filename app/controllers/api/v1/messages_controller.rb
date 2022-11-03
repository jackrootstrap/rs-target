# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApiController
      def create
        @message = conversation.messages.create!(message_params.merge({ user_id: current_user.id }))
      end

      private

      def message_params
        @message_params ||= params.permit(:body)
      end

      def conversation
        @conversation = Conversation.find(params[:conversation_id])
      end
    end
  end
end
