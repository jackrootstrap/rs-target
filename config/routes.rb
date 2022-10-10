# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: 'api/v1/sessions',
    registrations: 'api/v1/registrations'
  }

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :topics, only: [:index]
      resources :targets, only: %i[create]
    end
  end
end
