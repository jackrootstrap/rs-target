# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sign up', type: :request do
  let(:sign_up_url) { '/auth' }
  let(:user_attributes) { attributes_for(:user) }

  subject { post sign_up_url, params: sign_up_params }

  context 'when registration params are valid' do
    let(:sign_up_params) { { user: user_attributes } }

    it 'returns ok status' do
      subject

      expect(response).to have_http_status(:ok)
    end

    it 'creates an user object in database' do
      expect { subject }.to change(User, :count).by(1)
    end

    it 'sends email confirmation' do
      assert_emails 1 do
        subject
      end
    end

    it 'returns user information' do
      subject

      expect(json['data']).to include_json(
        email: user_attributes[:email],
        gender: user_attributes[:gender],
        name: user_attributes[:name]
      )
    end
  end

  context 'when registration params are invalid' do
    let(:sign_up_params) { { user: user_attributes.merge({ email: '' }) } }

    before { subject }

    it 'returns unprocessable entity status' do
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
