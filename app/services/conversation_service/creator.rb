# frozen_string_literal: true

module ConversationService
  class Creator
    def initialize(sender:, receivers:, topic:)
      @sender = sender
      @receivers = receivers
      @topic = topic
      @conversations = []
    end

    def call
      @receivers.each do |receiver|
        @conversations << Conversation.create(sender: @sender, receiver: receiver, topic: @topic)
      end
      @conversations
    end
  end
end
