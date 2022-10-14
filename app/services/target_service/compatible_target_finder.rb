# frozen_string_literal: true

module TargetService
  class CompatibleTargetFinder
    def initialize(target)
      @target = target
      @user = target.user
      @topic = target.topic
    end

    def call
      find_compatible_targets
    end

    private

    def match_targets
      @match_targets ||= Target.where.not(user: @user).where(topic: @topic)
    end

    def find_compatible_targets
      match_targets.each do |match_target|
        distance = Geocoder::Calculations.distance_between([@target.latitude, @target.longitude],
                                                           [match_target.latitude, match_target.longitude])
        if distance <= @target.radius + match_target.radius
          TargetNotification.with(user: @user).deliver_later(match_target.user)
        end
      end
    end
  end
end
