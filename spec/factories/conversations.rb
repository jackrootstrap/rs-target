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
FactoryBot.define do
  factory :conversation do
    sender { create(:user) }
    receiver { create(:user) }
    topic { create(:topic) }
  end
end
