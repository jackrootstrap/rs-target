# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'About page', type: :request do
  subject { get about_path }

  it 'returns an successful status' do
    subject

    expect(response).to have_http_status(:success)
  end
end
