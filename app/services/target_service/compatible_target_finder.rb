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
      compatible_targets = match_targets.within(@target.radius, origin: [@target.latitude, @target.longitude])
      TargetNotification.with(user: @user).deliver_later(compatible_targets.map(&:user))
    end
  end
end
