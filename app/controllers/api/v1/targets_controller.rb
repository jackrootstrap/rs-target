# frozen_string_literal: true

module Api
  module V1
    class TargetsController < ApiController
      def create
        @target = current_user.targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:radius, :latitude, :longitude, :title, :topic_id)
      end
    end
  end
end
