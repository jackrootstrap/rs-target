# frozen_string_literal: true

module Api
  module V1
    class ConversationsController < ApiController
      def index
        @conversations = UserConversationsQuery.for_user(current_user.id)
      end
    end
  end
end
