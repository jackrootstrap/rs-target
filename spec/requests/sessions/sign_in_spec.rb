# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up', type: :request do
  let(:sign_in_url) { '/auth/sign_in' }
  let(:user) { create(:user) }

  subject { post sign_in_url, params: sign_in_params }

  context 'when sign in params are valid' do
    let(:sign_in_params) do
      {
        user:
          {
            email: user.email,
            password: user.password
          }
      }
    end

    context 'when user has not confirmed the account' do
      before { subject }

      it 'returns unauthorized status' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns confirmation account message' do
        expect(errors.first).to include I18n.t('api.errors.confirmation_email')
      end
    end

    context 'when user has confirmed the account' do
      before do
        user.confirm
        subject
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns user information' do
        expect(json['data']).to include_json(
          email: user.email,
          gender: user.gender,
          name: user.name
        )
      end
    end
  end

  context 'when registration params are invalid' do
    let(:sign_in_params) { { user: attributes_for(:user) } }

    before { subject }

    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a message with the error' do
      expect(errors.first).to eq I18n.t('api.errors.invalid_credentials')
    end
  end
end
