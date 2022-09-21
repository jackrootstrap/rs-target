# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  describe 'Email registration' do
    let(:signup_url) { '/auth' }
    let(:signup_params) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end

    context 'when registration params are valid' do
      before do
        post signup_url, params: signup_params
      end

      it 'returns ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns an access token in header data' do
        expect(response.headers['access-token']).to be_present
      end
    end

    context 'when registration params are invalid' do
      before do
        post signup_url, params: nil
      end

      it 'returns unprocessable entity status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns unprocessable entity status' do
        expect(errors.first).to eq 'Please submit proper sign up data in request body.'
      end
    end
  end
end
