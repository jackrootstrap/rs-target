# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  describe 'Email registration' do
    let(:sign_up_url) { '/auth' }
    let(:password) { Faker::Internet.password }

    subject { post sign_up_url, params: sign_up_params }

    context 'when registration params are valid' do
      let(:sign_up_params) { attributes_for(:user) }

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
          email: sign_up_params[:email],
          gender: sign_up_params[:gender],
          name: sign_up_params[:name]
        )
      end
    end

    context 'when registration params are invalid' do
      let(:sign_up_params) { nil }

      before { subject }

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a message with the error' do
        expect(errors.first).to eq I18n.t('api.errors.invalid_body')
      end
    end
  end
end
