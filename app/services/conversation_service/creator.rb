# frozen_string_literal: true

module ConversationService
  class Creator
    attr_reader :sender, :receivers, :topic, :conversations

    def initialize(sender:, receivers:, topic:)
      @sender = sender
      @receivers = receivers
      @topic = topic
      @conversations = []
    end

    def call
      conversation_params = receivers.map do |receiver|
        { sender: sender, receiver: receiver, topic: topic }
      end
      Conversation.create!(conversation_params)
    end
  end
end
