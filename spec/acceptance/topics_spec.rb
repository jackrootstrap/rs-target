# frozen_string_literal: true

resource 'Topics' do
  let(:user) { create(:user) }

  route 'api/v1/topics', 'Topic index' do
    get 'Index' do
      context 'when user is not logged' do
        example 'Not logged user' do
          do_request

          expect(status).to eq 401
        end
      end

      context 'when user is logged' do
        header 'access-token', :access_token_header
        header 'client', :client_header
        header 'uid', :uid_header

        example 'Logged user' do
          do_request

          expect(status).to eq 200
        end
      end
    end
  end
end
