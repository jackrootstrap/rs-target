# frozen_string_literal: true

module Api
  module V1
    class TargetsController < ApiController
      def create
        current_user.targets << target
      end

      private

      def target_params
        params.require(:target).permit(:radius, :latitude, :longitude, :title, :topic_id, :user_id)
      end

      def target
        @target ||= Target.new(target_params)
      end
    end
  end
end
