# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Target', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:targets_response) { json['targets'] }
  let!(:targets) { create_list(:target, 3, user: user, topic: topic) }
  let(:targets_params) { attributes_for(:target, topic_id: topic.id) }

  describe 'GET /api/v1/targets' do
    subject { get api_v1_targets_path, headers: auth_headers, as: :json }

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

      it 'returns targets objects' do
        expect(targets_response.count).to eq targets.count
      end

      it 'returns targets object data' do
        expect(targets_response.first).to include_json(
          title: targets.first.title,
          radius: targets.first.radius.to_s,
          latitude: targets.first.latitude.to_s,
          longitude: targets.first.longitude.to_s,
          topic_id: topic.id
        )
      end
    end
  end
end
