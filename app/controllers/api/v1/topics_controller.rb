# frozen_string_literal: true

module Api
  module V1
    class TopicsController < ApiController
      before_action :authenticate_user!

      def index
        @topics = Topic.all
      end
    end
  end
end
