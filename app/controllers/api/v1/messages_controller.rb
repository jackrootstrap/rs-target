# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApiController
      def create
        @message = MessageService::Creator(conversation, body_message, current_user)
      end

      private

      def body_message
        @body_message ||= params.permit(:body)
      end

      def conversation
        @conversation ||= user_conversations.find(params[:conversation_id])
      end

      def user_conversations
        @user_conversations ||= UserConversationsQuery.for_user(current_user.id)
      end
    end
  end
end
