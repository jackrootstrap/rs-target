# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Target', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:target_response) { json['target'] }
  let(:targets_params) { attributes_for(:target).merge({ topic_id: topic.id }) }

  describe 'POST /api/v1/target' do
    subject { post api_v1_targets_path, params: targets_params, headers: auth_headers, as: :json }

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

      it 'returns targets response data' do
        expected_keys = targets_params.keys.map(&:to_s)

        expect(json.keys).to eq expected_keys
      end
    end
  end
end
