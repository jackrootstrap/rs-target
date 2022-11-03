# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages', type: :request do
  let(:user) { create(:user) }
  let!(:conversation) { create(:conversation, sender: user) }
  let(:body) { Faker::Lorem.paragraph }

  subject { post api_v1_conversation_messages_path(conversation), params: { body: body }, headers: auth_headers }

  before { subject }

  it 'returns success status' do
    expect(response).to have_http_status(:success)
  end

  it 'returns conversations object data' do
    expect(json).to include_json(
      body: body,
      user: user.name
    )
  end
end
