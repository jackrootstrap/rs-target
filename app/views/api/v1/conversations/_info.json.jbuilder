# frozen_string_literal: true

json.sender_id(conversation.sender.id)
json.sender(conversation.sender.name)
json.receiver_id(conversation.receiver.id)
json.receiver(conversation.receiver.name)
json.topic_id(conversation.topic.id)
json.topic(conversation.topic.name)
