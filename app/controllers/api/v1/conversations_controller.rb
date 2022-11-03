# frozen_string_literal: true

module Api
  module V1
    class ConversationsController < ApiController
      def index
        @conversations = Conversation.where('sender_id = ? OR receiver_id = ?', conversation_user_id,
                                            conversation_user_id)
      end

      private

      def conversation_user_id
        @conversation_user_id ||= current_user.id
      end
    end
  end
end
