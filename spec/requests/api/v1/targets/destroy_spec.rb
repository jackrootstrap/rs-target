# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Target', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let!(:targets) { create_list(:target, 3, user: user, topic: topic) }

  describe 'DELETE /api/v1/targets/:id' do
    let(:subject) { delete api_v1_target_path(target), headers: auth_headers, as: :json }

    context 'when user is not logged in' do
      let(:target) { targets.first.id }
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
      context 'when target belongs to user' do
        let(:target) { targets.first }

        it 'returns success status' do
          subject

          expect(response).to have_http_status(:success)
        end

        it 'returns success message' do
          subject

          expect(json['message']).to eq I18n.t('api.target.deleted')
        end

        it 'deletes the target record from the DB' do
          expect { subject }.to change(user.reload.targets, :count).by(-1)
        end
      end

      context 'when target does not belong to user' do
        let(:target) { create(:target) }

        before { subject }

        it 'returns bad request status' do
          expect(response).to have_http_status(:bad_request)
        end

        it 'returns an error message' do
          expect(errors).to include I18n.t('api.errors.target_not_found')
        end
      end
    end
  end
end
