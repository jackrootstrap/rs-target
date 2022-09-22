# frozen_string_literal: true

resource 'Sessions' do
  header 'access-token', :access_token_header
  header 'client', :client_header
  header 'uid', :uid_header

  let(:user) { create(:user) }

  route 'auth/sign_out', 'Sign out' do
    let(:request) do
      {
        user:
          {
            email: user.email,
            password: user.password
          }
      }
    end

    delete 'Delete' do
      example 'Ok' do
        do_request(request)

        expect(status).to eq 200
      end
    end
  end
end
