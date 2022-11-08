# frozen_string_literal: true

class UserConversationsQuery
  def self.conversations
    @conversations ||= Conversation.all
  end

  def self.for_user(user_id)
    conversations.where('sender_id = :user_id OR receiver_id = :user_id', user_id: user_id)
  end

  def self.between(sender_id, receiver_ids, topic_id)
    conversations.where('((sender_id = :sender_id AND receiver_id IN (:receiver_ids)) ' \
                        'OR (receiver_id = :sender_id AND sender_id IN (:receiver_ids))) ' \
                        'AND topic_id = :topic_id', sender_id: sender_id, receiver_ids: receiver_ids,
                                                    topic_id: topic_id)
  end
end
