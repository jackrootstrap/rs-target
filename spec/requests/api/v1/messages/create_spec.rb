# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let(:conversation) { create(:conversation, sender: user) }
  let(:body) { Faker::Lorem.paragraph }
  let(:message) { Message.last }

  subject { post api_v1_conversation_messages_path(conversation), params: { body: body }, headers: auth_headers }

  context 'when conversation belongs to user' do
    it 'returns success status' do
      subject

      expect(response).to have_http_status(:success)
    end

    it 'creates a new message object' do
      expect { subject }.to change(conversation.messages, :count).by(1)
    end

    it 'returns message object data' do
      subject

      expect(json).to include_json(
        message_id: message.id,
        body: body,
        user_id: user.id,
        user: user.name
      )
    end
  end

  context 'when conversation does not belong to user' do
    let(:new_user) { create(:user) }
    let(:auth_headers) { new_user.create_new_auth_token }

    it 'returns not found status' do
      subject

      expect(response).to have_http_status(:not_found)
    end

    it 'does not create a new message object' do
      expect { subject }.to change(conversation.messages, :count).by(0)
    end

    it 'returns an error message' do
      subject

      expect(errors).to include I18n.t('api.errors.conversation_not_found')
    end
  end
end
