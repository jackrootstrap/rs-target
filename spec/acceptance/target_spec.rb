# frozen_string_literal: true

resource 'Targets' do
  header 'access-token', :access_token_header
  header 'client', :client_header
  header 'uid', :uid_header

  let(:user) { create(:user) }
  let(:topic) { create(:topic) }

  route 'api/v1/targets', 'Create target' do
    post 'Create' do
      context 'with valid params' do
        let(:request) { { target: attributes_for(:target).merge({ topic_id: topic.id }) } }

        example 'Ok' do
          do_request(request)

          expect(status).to eq 200
        end
      end

      context 'with invalid params' do
        let(:request) { { target: attributes_for(:target).except(:title) } }

        example 'Bad' do
          do_request(request)

          expect(status).to eq 422
        end
      end
    end
  end

  route 'api/v1/targets', 'Index target' do
    get 'Index' do
      example 'Index' do
        do_request

        expect(status).to eq 200
      end
    end
  end
end
