# frozen_string_literal: true

module TargetService
  class Creator
    def initialize(targets, target_params)
      @targets = targets
      @target_params = target_params
    end

    def call
      @targets.create!(@target_params)
    end
  end
end
