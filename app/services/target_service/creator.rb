# frozen_string_literal: true

module TargetService
  class Creator
    def initialize(targets, target_params)
      @targets = targets
      @target_params = target_params
    end

    def call
      target = @targets.create!(@target_params)
      TargetService::CompatibleTargetFinder.new(target).call
      target
    end
  end
end
