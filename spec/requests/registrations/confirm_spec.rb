# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Confirmation account', type: :request do
  let(:create_user_request) { post user_registration_path, params: sign_up_params }
  let(:sign_up_params) { { user: attributes_for(:user) } }
  let(:sent_email) { ActionMailer::Base.deliveries.last }
  let(:confirmation_url) { URI.extract(sent_email.body.raw_source, 'http').first }
  let(:user) { User.last }

  subject { get confirmation_url }

  before { create_user_request }

  context 'when account is not confirmed' do
    it 'returns a unconfirmed user' do
      expect(user.confirmed?).to be false
    end
  end

  context 'when account is confirmed' do
    before { subject }

    it 'returns a confirmed user' do
      expect(user.confirmed?).to be true
    end
  end
end
