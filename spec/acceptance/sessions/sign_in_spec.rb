# frozen_string_literal: true

resource 'Sessions' do
  let(:user) { create(:user) }

  route 'auth/sign_in', 'Sign in' do
    let(:request) do
      {
        user:
          {
            email: user.email,
            password: user.password
          }
      }
    end

    post 'Create' do
      context 'when user has not confirmed the account' do
        example 'Unconfirmed user' do
          do_request(request)

          expect(status).to eq 401
          expect(response_body).to include I18n.t('api.errors.confirmation_email')
        end
      end

      context 'when user confirms the account' do
        before { user.confirm }

        example 'Confirmed user' do
          do_request(request)

          expect(status).to eq 200
        end

        example 'Wrong password' do
          request[:user][:password] = 'wrong-password'
          do_request(request)

          expect(status).to eq 401
          expect(response_body).to include I18n.t('api.errors.invalid_credentials')
        end
      end
    end
  end
end
