# frozen_string_literal: true

module Api
  module V1
    class ConversationsController < ApiController
      def index
        @conversations = UserConversationsQuery.new(current_user.id).call
      end
    end
  end
end
