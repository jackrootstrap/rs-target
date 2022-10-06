# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Topic', type: :request do
  let(:user) { create(:user) }
  let(:topics_response) { json['topics'] }
  let!(:topics) { create_list(:topic, 3) }

  describe 'GET /api/v1/topics' do
    subject { get api_v1_topics_path, headers: auth_headers, as: :json }

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

      it 'returns topics response objects' do
        expect(topics_response.count).to eq topics.count
      end

      it 'returns topics response data' do
        expect(topics_response.first).to include_json(
          id: topics.first[:id],
          name: topics.first[:name]
        )
      end
    end
  end
end
