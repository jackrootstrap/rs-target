# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Target', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:targets_attributes) { attributes_for(:target, topic_id: topic.id) }
  let(:targets_params) { targets_attributes }

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
      context 'when params are valid' do
        let(:target_user) { user.targets.first }

        it 'returns success status' do
          subject

          expect(response).to have_http_status(:success)
        end

        it 'returns targets response data' do
          subject

          expect(json).to include_json(
            title: targets_params[:title],
            radius: targets_params[:radius].to_s,
            latitude: targets_params[:latitude].to_s,
            longitude: targets_params[:longitude].to_s,
            topic_id: targets_params[:topic_id]
          )
        end

        it 'returns targets object data' do
          subject

          expect(json).to include_json(
            title: target_user.title,
            radius: target_user.radius.to_s,
            latitude: target_user.latitude.to_s,
            longitude: target_user.longitude.to_s,
            topic_id: target_user.topic_id
          )
        end

        it 'creates a new target record on the DB' do
          expect { subject }.to change(user.reload.targets, :count).by(1)
        end
      end

      context 'when params are invalid' do
        let(:targets_params) { targets_attributes.except(:title) }

        before { subject }

        it 'returns success status' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'returns an error message' do
          expect(errors).to include I18n.t('api.errors.title_not_blank')
        end
      end
    end
  end
end
