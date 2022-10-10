# frozen_string_literal: true

resource 'Registrations' do
  let(:user_attributes) { attributes_for(:user) }

  route 'auth/', 'Session' do
    post 'Create' do
      context 'when attributes are invalid' do
        let(:request) { { user: user_attributes.merge({ email: '' }) } }

        example 'Invalid params' do
          do_request(request)

          expect(status).to eq 422
          expect(response_body).to include I18n.t('api.errors.email_not_blank')
        end
      end

      context 'when attributes are valid' do
        let(:request) { { user: user_attributes } }

        example 'Valid params' do
          do_request(request)

          expect(status).to eq 200
        end
      end
    end
  end
end
