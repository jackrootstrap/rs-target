# frozen_string_literal: true

# == Schema Information
#
# Table name: conversations
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  receiver_id :bigint           not null
#  sender_id   :bigint           not null
#  topic_id    :bigint           not null
#
# Indexes
#
#  index_conversations_on_receiver_id  (receiver_id)
#  index_conversations_on_sender_id    (sender_id)
#  index_conversations_on_topic_id     (topic_id)
#  user_conversations                  (sender_id,receiver_id,topic_id) UNIQUE
#
class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  belongs_to :topic

  validates :topic, uniqueness: { scope: %i[receiver_id sender_id] }

  scope :between, lambda { |sender_id, receiver_ids, topic_id|
    where('((sender_id = ? AND receiver_id IN (?)) OR (receiver_id = ? AND sender_id IN (?))) ' \
          'AND topic_id = ?', sender_id, receiver_ids, sender_id, receiver_ids, topic_id)
  }

  scope :user_conversations, ->(user_id) { where('sender_id = ? OR receiver_id = ?', user_id, user_id) }
end
