# frozen_string_literal: true

module TargetService
  class CompatibleTargetFinder
    def initialize(target)
      @target = target
      @user = target.user
      @topic = target.topic
    end

    def call
      ConversationService::Creator.new(sender: @user, receivers: targeted_users, topic: @topic).call
      TargetNotification.with(user: @user).deliver_later(targeted_users)
    end

    private

    def match_targets
      @match_targets ||= Target.where.not(user: @user).where(topic: @topic)
    end

    def compatible_targets
      @compatible_targets ||= match_targets.within(@target.radius, origin: [@target.latitude, @target.longitude])
    end

    def compatible_users
      @compatible_users ||= User.find(compatible_targets.pluck(:user_id))
    end

    def current_conversations
      @current_conversations ||= UserConversationsQuery.between(@user.id, compatible_users.pluck(:id), @topic.id)
    end

    def user_conversations_ids
      @user_conversations_ids ||= current_conversations.pluck(:sender_id, :receiver_id).flatten.uniq
    end

    def targeted_users
      @targeted_users ||= User.where(id: compatible_users.pluck(:id)).where.not(id: user_conversations_ids)
    end
  end
end
