# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApiController
      def create
        @message = conversation.messages.create!(body: message_params[:body], user_id: current_user.id)
      end

      private

      def message_params
        @message_params ||= params.permit(:body)
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
