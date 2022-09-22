# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up', type: :request do
  let(:sign_out_url) { '/auth/sign_out' }
  let(:user) { create(:user) }

  subject { delete sign_out_url, headers: auth_headers }

  context 'User signed out' do
    it 'returns ok status' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end

  context 'when registration params are invalid' do
    let(:auth_headers) { nil }

    before { subject }

    it 'returns not_found status' do
      expect(response).to have_http_status(:not_found)
    end

    it 'returns a message with the error' do
      expect(errors.first).to eq I18n.t('api.errors.user_not_logged')
    end
  end
end
