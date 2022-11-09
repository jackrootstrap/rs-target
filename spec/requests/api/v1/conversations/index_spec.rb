# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Conversation', type: :request do
  let(:user) { create(:user) }
  let(:receivers) { create_list(:user, 4) }
  let(:topic) { create(:topic) }
  let(:conversations_response) { json['conversations'] }
  let!(:conversations) do
    receivers.map do |receiver|
      create(:conversation, sender: user, receiver: receiver, topic: topic)
    end
  end

  describe 'GET /api/v1/conversations' do
    subject { get api_v1_conversations_path, headers: auth_headers, as: :json }

    context 'when user is not logged in' do
      let(:auth_headers) { nil }

      before { subject }

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns an error message' do
        expect(errors.first).to eq I18n.t('api.errors.user_not_logged')
      end
    end

    context 'when user is logged in' do
      before { subject }

      it 'returns success status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns conversations objects' do
        expect(conversations_response.count).to eq conversations.count
      end

      it 'returns conversations object data' do
        expect(conversations_response.first).to include_json(
          sender: conversations.first.sender.name,
          receiver: conversations.first.receiver.name,
          topic: conversations.first.topic.name
        )
      end
    end
  end
end
