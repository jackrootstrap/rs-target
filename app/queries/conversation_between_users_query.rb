# frozen_string_literal: true

class ConversationBetweenUsersQuery
  attr_reader :relation, :sender_id, :receiver_ids, :topic_id

  def initialize(sender_id, receiver_ids, topic_id, relation = Conversation.all)
    @relation = relation
    @sender_id = sender_id
    @receiver_ids = receiver_ids
    @topic_id = topic_id
  end

  def call
    relation.where('((sender_id = ? AND receiver_id IN (?)) OR (receiver_id = ? AND sender_id IN (?))) ' \
                   'AND topic_id = ?', sender_id, receiver_ids, sender_id, receiver_ids, topic_id)
  end
end
