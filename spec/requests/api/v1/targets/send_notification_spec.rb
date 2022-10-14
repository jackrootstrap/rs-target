# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Target', type: :request do
  let!(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:targets_attributes) { attributes_for(:target, topic_id: topic.id, user_id: user.id) }
  let!(:target) { create(:target, targets_attributes) }

  describe 'POST /api/v1/target' do
    let(:new_user) { create(:user) }
    let(:auth_headers) { new_user.create_new_auth_token }
    let(:targets_params) { targets_attributes }

    subject { post api_v1_targets_path, params: targets_params, headers: auth_headers, as: :json }

    context 'when new target matches the old target' do
      it 'returns success status' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'sends a notification to the matching target owners' do
        expect { subject }.to change(user.notifications, :count).by(1)
      end
    end

    context 'when new target does not match the old target' do
      let(:new_topic) { create(:topic) }
      let(:targets_params) { targets_attributes.merge({ topic_id: new_topic.id }) }

      it 'returns success status' do
        subject

        expect(response).to have_http_status(:success)
      end

      it 'does not send any notification' do
        expect { subject }.to_not change(user.notifications, :count)
      end
    end
  end
end
