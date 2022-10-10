# frozen_string_literal: true

module Api
  module V1
    class TargetsController < ApiController
      def index
        targets
      end

      def create
        @target = targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:radius, :latitude, :longitude, :title, :topic_id)
      end

      def targets
        @targets ||= current_user.targets
      end
    end
  end
end
