# frozen_string_literal: true

class UserConversationsQuery
  attr_reader :relation, :user_id

  def initialize(user_id, relation = Conversation.all)
    @relation = relation
    @user_id = user_id
  end

  def call
    relation.where('sender_id = ? OR receiver_id = ?', user_id, user_id)
  end
end
