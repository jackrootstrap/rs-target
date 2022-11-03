# frozen_string_literal: true

module TargetService
  class CompatibleTargetFinder
    def initialize(target)
      @target = target
      @user = target.user
      @topic = target.topic
    end

    def call
      TargetNotification.with(user: @user).deliver_later(targeted_users)
      ConversationService::Creator.new(sender: @user, receivers: targeted_users, topic: @topic).call
    end

    private

    def match_targets
      @match_targets ||= Target.where.not(user: @user).where(topic: @topic)
    end

    def compatible_targets
      @compatible_targets ||= match_targets.within(@target.radius, origin: [@target.latitude, @target.longitude])
    end

    def compatible_users
      @compatible_users ||= compatible_targets.map(&:user)
    end

    def current_conversations
      @current_conversations ||= Conversation.between(@user.id, compatible_users.map(&:id), @topic.id)
    end

    def user_conversations_ids
      @user_conversations_ids ||= current_conversations.map { |cv| [cv.sender_id, cv.receiver_id] }.flatten.uniq
    end

    def targeted_users
      @targeted_users ||= compatible_users.reject { |user| user_conversations_ids.include?(user.id) }
    end
  end
end
