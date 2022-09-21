# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registration', type: :request do
  describe 'Email registration' do
    let(:sign_up_url) { '/auth' }
    let(:password) { Faker::Internet.password }
    let(:sign_up_params) do
      {
        email: Faker::Internet.email,
        password: password,
        password_confirmation: password,
        gender: Faker::Gender.type
      }
    end

    context 'when registration params are valid' do
      subject { post sign_up_url, params: sign_up_params }

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
          gender: sign_up_params[:gender]
        )
      end
    end

    context 'when registration params are invalid' do
      before do
        post sign_up_url, params: nil
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
