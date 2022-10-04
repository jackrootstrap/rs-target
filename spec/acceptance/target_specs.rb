# frozen_string_literal: true

resource 'Targets' do
  header 'access-token', :access_token_header
  header 'client', :client_header
  header 'uid', :uid_header

  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:request) { { target: attributes_for(:target).merge({ topic_id: topic.id }) } }

  route 'api/v1/targets', 'Create target' do
    post 'Create' do
      example 'Ok' do
        do_request(request)

        expect(status).to eq 200
      end
    end
  end
end
